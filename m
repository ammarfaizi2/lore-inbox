Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUDGFhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 01:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUDGFhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 01:37:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:7953 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264098AbUDGFdg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 01:33:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       celinux-dev@tree.celinuxforum.org
Subject: Re: 2.6.5-rc1-tiny1 for small systems
Date: Wed, 7 Apr 2004 08:33:25 +0300
X-Mailer: KMail [version 1.4]
References: <20040316222548.GD11010@waste.org>
In-Reply-To: <20040316222548.GD11010@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404070833.26197.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 March 2004 00:25, Matt Mackall wrote:
> This is the latest release of the -tiny kernel tree. The aim of this
> tree is to collect patches that reduce kernel disk and memory
> footprint as well as tools for working on small systems. Target users
> are things like embedded systems, small or legacy desktop folks, and
> handhelds.
>
> This release is primarily a resync with 2.6.5-rc1 and contains various
> compile fixes and other cleanups.
>
> The patch can be found at:
>
>  http://selenic.com/tiny/2.6.5-rc1-tiny1.patch.bz2
>  http://selenic.com/tiny/2.6.5-rc1-tiny1-broken-out.tar.bz2
>
> Webpage for your bookmarking pleasure:
>
>  http://selenic.com/tiny-about/

With attached .config, I get this:
  CC      lib/div64.o
  CC      lib/dump_stack.o
  CC      lib/errno.o
  CC      lib/extable.o
  CC      lib/idr.o
  CC      lib/inflate.o
lib/inflate.c:138: syntax error before "void"
make[1]: *** [lib/inflate.o] Error 1
make: *** [lib] Error 2

lib/inflate.c:
static u32 crc_32_tab[256];

static INIT void makecrc(void)
       ^^^^
{
        unsigned i, j;
        u32 c = 1;


Originally I wanted to have CONFIG_MEASURE_INLINES=y,
but it died even earlier, looks like my gcc does not like
the fact that there is way too many warnings for
eisa-bus.c.

My gcc:
# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-pc-linux-gnu/3.2/specs
Configured with: ../gcc-3.2/configure --prefix=/usr/app/gcc-3.2 --exec-prefix=/usr/app/gcc-3.2 --bindir=/usr/app/gcc-3.2/bin --libdir=/usr/lib --infodir=/usr/app/gcc-3.2/info --mandir=/usr/app/gcc-3.2/man --with-slibdir=/usr/lib --with-local-prefix=/usr/local --with-gxx-include-dir=/usr/app/gcc-3.2/include/g++-v3 --enable-threads=posix i386-pc-linux-gnu
Thread model: posix
gcc version 3.2

Now, actual warnings for eisa-bus.c, followed by .config
(sans CONFIG_MEASURE_INLINES=y), are below sig
--
vda

......
  CC      drivers/eisa/eisa-bus.o
cc1: warnings being treated as errors
In file included from include/linux/byteorder/little_endian.h:11,
                 from include/asm/byteorder.h:57,
                 from include/linux/kernel.h:15,
                 from drivers/eisa/eisa-bus.c:9:
include/linux/byteorder/swab.h: In function `__fswab32':
include/linux/byteorder/swab.h:148: warning: `___arch__swab32' is deprecated (declared at include/asm/byteorder.h:15)
include/linux/byteorder/swab.h: In function `__swab32p':
include/linux/byteorder/swab.h:152: warning: `___arch__swab32' is deprecated (declared at include/asm/byteorder.h:15)
include/linux/byteorder/swab.h: In function `__swab32s':
include/linux/byteorder/swab.h:156: warning: `___arch__swab32' is deprecated (declared at include/asm/byteorder.h:15)
include/linux/byteorder/swab.h: In function `__fswab64':
include/linux/byteorder/swab.h:167: warning: `___arch__swab64' is deprecated (declared at include/asm/byteorder.h:29)
include/linux/byteorder/swab.h: In function `__swab64p':
include/linux/byteorder/swab.h:172: warning: `___arch__swab64' is deprecated (declared at include/asm/byteorder.h:29)
include/linux/byteorder/swab.h: In function `__swab64s':
include/linux/byteorder/swab.h:176: warning: `___arch__swab64' is deprecated (declared at include/asm/byteorder.h:29)
In file included from include/linux/bitops.h:4,
                 from include/asm/cpufeature.h:10,
                 from include/asm/processor.h:16,
                 from include/linux/prefetch.h:13,
                 from include/linux/list.h:7,
                 from include/linux/kobject.h:19,
                 from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/asm/bitops.h: In function `find_next_zero_bit':
include/asm/bitops.h:354: warning: `find_first_zero_bit' is deprecated (declared at include/asm/bitops.h:274)
include/asm/bitops.h: In function `find_next_bit':
include/asm/bitops.h:387: warning: `find_first_bit' is deprecated (declared at include/asm/bitops.h:306)
include/asm/bitops.h: In function `sched_find_first_bit':
include/asm/bitops.h:436: warning: `__ffs' is deprecated (declared at include/asm/bitops.h:412)
include/asm/bitops.h:438: warning: `__ffs' is deprecated (declared at include/asm/bitops.h:412)
include/asm/bitops.h:440: warning: `__ffs' is deprecated (declared at include/asm/bitops.h:412)
include/asm/bitops.h:442: warning: `__ffs' is deprecated (declared at include/asm/bitops.h:412)
include/asm/bitops.h:443: warning: `__ffs' is deprecated (declared at include/asm/bitops.h:412)
In file included from include/asm/cpufeature.h:10,
                 from include/asm/processor.h:16,
                 from include/linux/prefetch.h:13,
                 from include/linux/list.h:7,
                 from include/linux/kobject.h:19,
                 from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/bitops.h: In function `get_bitmask_order':
include/linux/bitops.h:78: warning: `generic_fls' is deprecated (declared at include/linux/bitops.h:46)
include/linux/bitops.h: In function `generic_hweight64':
include/linux/bitops.h:114: warning: `generic_hweight32' is deprecated (declared at include/linux/bitops.h:88)
include/linux/bitops.h:115: warning: `generic_hweight32' is deprecated (declared at include/linux/bitops.h:88)
include/linux/bitops.h: In function `hweight_long':
include/linux/bitops.h:129: warning: `generic_hweight32' is deprecated (declared at include/linux/bitops.h:88)
include/linux/bitops.h:129: warning: `generic_hweight64' is deprecated (declared at include/linux/bitops.h:112)
In file included from include/asm/processor.h:18,
                 from include/linux/prefetch.h:13,
                 from include/linux/list.h:7,
                 from include/linux/kobject.h:19,
                 from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/asm/system.h: In function `__set_64bit_constant':
include/asm/system.h:185: warning: `__set_64bit' is deprecated (declared at include/asm/system.h:168)
include/asm/system.h: In function `__set_64bit_var':
include/asm/system.h:193: warning: `__set_64bit' is deprecated (declared at include/asm/system.h:168)
In file included from include/linux/kobject.h:19,
                 from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/list.h: In function `list_add':
include/linux/list.h:67: warning: `__list_add' is deprecated (declared at include/linux/list.h:50)
include/linux/list.h: In function `list_add_tail':
include/linux/list.h:80: warning: `__list_add' is deprecated (declared at include/linux/list.h:50)
include/linux/list.h: In function `list_add_rcu':
include/linux/list.h:110: warning: `__list_add_rcu' is deprecated (declared at include/linux/list.h:92)
include/linux/list.h: In function `list_add_tail_rcu':
include/linux/list.h:123: warning: `__list_add_rcu' is deprecated (declared at include/linux/list.h:92)
include/linux/list.h: In function `list_del':
include/linux/list.h:147: warning: `__list_del' is deprecated (declared at include/linux/list.h:134)
include/linux/list.h: In function `list_del_rcu':
include/linux/list.h:165: warning: `__list_del' is deprecated (declared at include/linux/list.h:134)
include/linux/list.h: In function `list_del_init':
include/linux/list.h:175: warning: `__list_del' is deprecated (declared at include/linux/list.h:134)
include/linux/list.h: In function `list_move':
include/linux/list.h:186: warning: `__list_del' is deprecated (declared at include/linux/list.h:134)
include/linux/list.h:187: warning: `list_add' is deprecated (declared at include/linux/list.h:66)
include/linux/list.h: In function `list_move_tail':
include/linux/list.h:198: warning: `__list_del' is deprecated (declared at include/linux/list.h:134)
include/linux/list.h:199: warning: `list_add_tail' is deprecated (declared at include/linux/list.h:79)
include/linux/list.h: In function `list_splice':
include/linux/list.h:250: warning: `list_empty' is deprecated (declared at include/linux/list.h:207)
include/linux/list.h:251: warning: `__list_splice' is deprecated (declared at include/linux/list.h:231)
include/linux/list.h: In function `list_splice_init':
include/linux/list.h:264: warning: `list_empty' is deprecated (declared at include/linux/list.h:207)
include/linux/list.h:265: warning: `__list_splice' is deprecated (declared at include/linux/list.h:231)
include/linux/list.h: In function `hlist_del':
include/linux/list.h:473: warning: `__hlist_del' is deprecated (declared at include/linux/list.h:463)
include/linux/list.h: In function `hlist_del_rcu':
include/linux/list.h:491: warning: `__hlist_del' is deprecated (declared at include/linux/list.h:463)
include/linux/list.h: In function `hlist_del_init':
include/linux/list.h:498: warning: `__hlist_del' is deprecated (declared at include/linux/list.h:463)
In file included from include/linux/spinlock.h:12,
                 from include/asm/rwsem.h:42,
                 from include/linux/rwsem.h:27,
                 from include/linux/kobject.h:21,
                 from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/thread_info.h: In function `set_thread_flag':
include/linux/thread_info.h:32: warning: `set_bit' is deprecated (declared at include/asm/bitops.h:38)
include/linux/thread_info.h:32: warning: `current_thread_info' is deprecated (declared at include/asm/thread_info.h:95)
include/linux/thread_info.h: In function `clear_thread_flag':
include/linux/thread_info.h:37: warning: `clear_bit' is deprecated (declared at include/asm/bitops.h:73)
include/linux/thread_info.h:37: warning: `current_thread_info' is deprecated (declared at include/asm/thread_info.h:95)
include/linux/thread_info.h: In function `test_and_set_thread_flag':
include/linux/thread_info.h:42: warning: `test_and_set_bit' is deprecated (declared at include/asm/bitops.h:133)
include/linux/thread_info.h:42: warning: `current_thread_info' is deprecated (declared at include/asm/thread_info.h:95)
include/linux/thread_info.h: In function `test_and_clear_thread_flag':
include/linux/thread_info.h:47: warning: `test_and_clear_bit' is deprecated (declared at include/asm/bitops.h:172)
include/linux/thread_info.h:47: warning: `current_thread_info' is deprecated (declared at include/asm/thread_info.h:95)
include/linux/thread_info.h: In function `test_thread_flag':
include/linux/thread_info.h:52: warning: `constant_test_bit' is deprecated (declared at include/asm/bitops.h:243)
include/linux/thread_info.h:52: warning: `current_thread_info' is deprecated (declared at include/asm/thread_info.h:95)
include/linux/thread_info.h:52: warning: `variable_test_bit' is deprecated (declared at include/asm/bitops.h:248)
include/linux/thread_info.h:52: warning: `current_thread_info' is deprecated (declared at include/asm/thread_info.h:95)
include/linux/thread_info.h: In function `set_ti_thread_flag':
include/linux/thread_info.h:57: warning: `set_bit' is deprecated (declared at include/asm/bitops.h:38)
include/linux/thread_info.h: In function `clear_ti_thread_flag':
include/linux/thread_info.h:62: warning: `clear_bit' is deprecated (declared at include/asm/bitops.h:73)
include/linux/thread_info.h: In function `test_and_set_ti_thread_flag':
include/linux/thread_info.h:67: warning: `test_and_set_bit' is deprecated (declared at include/asm/bitops.h:133)
include/linux/thread_info.h: In function `test_and_clear_ti_thread_flag':
include/linux/thread_info.h:72: warning: `test_and_clear_bit' is deprecated (declared at include/asm/bitops.h:172)
include/linux/thread_info.h: In function `test_ti_thread_flag':
include/linux/thread_info.h:77: warning: `constant_test_bit' is deprecated (declared at include/asm/bitops.h:243)
include/linux/thread_info.h:77: warning: `variable_test_bit' is deprecated (declared at include/asm/bitops.h:248)
include/linux/thread_info.h: In function `set_need_resched':
include/linux/thread_info.h:82: warning: `set_thread_flag' is deprecated (declared at include/linux/thread_info.h:31)
include/linux/thread_info.h: In function `clear_need_resched':
include/linux/thread_info.h:87: warning: `clear_thread_flag' is deprecated (declared at include/linux/thread_info.h:36)
In file included from include/linux/rwsem.h:27,
                 from include/linux/kobject.h:21,
                 from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/asm/rwsem.h: In function `__down_write_trylock':
include/asm/rwsem.h:177: warning: `__cmpxchg' is deprecated (declared at include/asm/system.h:248)
In file included from include/linux/kobject.h:21,
                 from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/rwsem.h: In function `down_read':
include/linux/rwsem.h:45: warning: `__down_read' is deprecated (declared at include/asm/rwsem.h:99)
include/linux/rwsem.h: In function `down_read_trylock':
include/linux/rwsem.h:56: warning: `__down_read_trylock' is deprecated (declared at include/asm/rwsem.h:124)
include/linux/rwsem.h: In function `down_write':
include/linux/rwsem.h:68: warning: `__down_write' is deprecated (declared at include/asm/rwsem.h:147)
include/linux/rwsem.h: In function `down_write_trylock':
include/linux/rwsem.h:79: warning: `__down_write_trylock' is deprecated (declared at include/asm/rwsem.h:174)
include/linux/rwsem.h: In function `up_read':
include/linux/rwsem.h:90: warning: `__up_read' is deprecated (declared at include/asm/rwsem.h:187)
include/linux/rwsem.h: In function `up_write':
include/linux/rwsem.h:100: warning: `__up_write' is deprecated (declared at include/asm/rwsem.h:213)
include/linux/rwsem.h: In function `downgrade_write':
include/linux/rwsem.h:110: warning: `__downgrade_write' is deprecated (declared at include/asm/rwsem.h:239)
In file included from include/linux/device.h:16,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/kobject.h: In function `kset_get':
include/linux/kobject.h:114: warning: `to_kset' is deprecated (declared at include/linux/kobject.h:108)
include/linux/kobject.h: In function `subsys_get':
include/linux/kobject.h:215: warning: `kset_get' is deprecated (declared at include/linux/kobject.h:113)
include/linux/kobject.h: In function `subsys_put':
include/linux/kobject.h:220: warning: `kset_put' is deprecated (declared at include/linux/kobject.h:118)
In file included from include/linux/timex.h:186,
                 from include/linux/sched.h:11,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/time.h: In function `jiffies_to_timespec':
include/linux/time.h:215: warning: `div_ll_X_l_rem' is deprecated (declared at include/asm/div64.h:40)
include/linux/time.h: In function `jiffies_to_timeval':
include/linux/time.h:253: warning: `div_ll_X_l_rem' is deprecated (declared at include/asm/div64.h:40)
In file included from include/linux/string.h:23,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:5,
                 from include/linux/sched.h:15,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/asm/string.h: In function `memmove':
include/asm/string.h:301: warning: `__constant_memcpy' is deprecated (declared at include/asm/string.h:214)
include/asm/string.h:301: warning: `__memcpy' is deprecated (declared at include/asm/string.h:192)
In file included from include/linux/cpumask.h:5,
                 from include/linux/sched.h:15,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/bitmap.h: In function `bitmap_clear':
include/linux/bitmap.h:21: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
include/linux/bitmap.h:21: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
include/linux/bitmap.h:21: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/bitmap.h:21: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/bitmap.h: In function `bitmap_fill':
include/linux/bitmap.h:26: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
include/linux/bitmap.h:26: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
include/linux/bitmap.h:26: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/bitmap.h:26: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/bitmap.h: In function `bitmap_copy':
include/linux/bitmap.h:32: warning: `__constant_memcpy' is deprecated (declared at include/asm/string.h:214)
include/linux/bitmap.h:32: warning: `__memcpy' is deprecated (declared at include/asm/string.h:192)
In file included from include/asm/semaphore.h:41,
                 from include/linux/sched.h:18,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/wait.h: In function `waitqueue_active':
include/linux/wait.h:80: warning: `list_empty' is deprecated (declared at include/linux/list.h:207)
include/linux/wait.h: In function `__add_wait_queue':
include/linux/wait.h:89: warning: `list_add' is deprecated (declared at include/linux/list.h:66)
include/linux/wait.h: In function `__add_wait_queue_tail':
include/linux/wait.h:98: warning: `list_add_tail' is deprecated (declared at include/linux/list.h:79)
include/linux/wait.h: In function `__remove_wait_queue':
include/linux/wait.h:104: warning: `list_del' is deprecated (declared at include/linux/list.h:146)
include/linux/wait.h: In function `add_wait_queue_exclusive_locked':
include/linux/wait.h:211: warning: `__add_wait_queue_tail' is deprecated (declared at include/linux/wait.h:97)
include/linux/wait.h: In function `remove_wait_queue_locked':
include/linux/wait.h:220: warning: `__remove_wait_queue' is deprecated (declared at include/linux/wait.h:103)
In file included from include/linux/sched.h:18,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/asm/semaphore.h: In function `sema_init':
include/asm/semaphore.h:83: warning: `init_waitqueue_head' is deprecated (declared at include/linux/wait.h:58)
include/asm/semaphore.h: In function `init_MUTEX':
include/asm/semaphore.h:91: warning: `sema_init' is deprecated (declared at include/asm/semaphore.h:74)
include/asm/semaphore.h: In function `init_MUTEX_LOCKED':
include/asm/semaphore.h:96: warning: `sema_init' is deprecated (declared at include/asm/semaphore.h:74)
In file included from include/asm/siginfo.h:4,
                 from include/linux/signal.h:7,
                 from include/linux/sched.h:25,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/asm-generic/siginfo.h: In function `copy_siginfo':
include/asm-generic/siginfo.h:284: warning: `__constant_memcpy' is deprecated (declared at include/asm/string.h:214)
include/asm-generic/siginfo.h:284: warning: `__memcpy' is deprecated (declared at include/asm/string.h:192)
include/asm-generic/siginfo.h:287: warning: `__constant_memcpy' is deprecated (declared at include/asm/string.h:214)
include/asm-generic/siginfo.h:287: warning: `__memcpy' is deprecated (declared at include/asm/string.h:192)
In file included from include/linux/sched.h:25,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/signal.h: In function `sigemptyset':
include/linux/signal.h:141: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
include/linux/signal.h:141: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
include/linux/signal.h:141: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h:141: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h: In function `sigfillset':
include/linux/signal.h:153: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
include/linux/signal.h:153: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
include/linux/signal.h:153: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h:153: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h: In function `siginitset':
include/linux/signal.h:183: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
include/linux/signal.h:183: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
include/linux/signal.h:183: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h:183: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h: In function `siginitsetinv':
include/linux/signal.h:195: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
include/linux/signal.h:195: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
include/linux/signal.h:195: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h:195: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/signal.h: In function `init_sigpending':
include/linux/signal.h:206: warning: `sigemptyset' is deprecated (declared at include/linux/signal.h:138)
In file included from include/linux/sched.h:29,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/completion.h: In function `init_completion':
include/linux/completion.h:27: warning: `init_waitqueue_head' is deprecated (declared at include/linux/wait.h:58)
In file included from include/linux/sched.h:31,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/percpu.h: In function `__alloc_percpu':
include/linux/percpu.h:45: warning: `kmalloc' is deprecated (declared at include/linux/slab.h:97)
include/linux/percpu.h:47: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
include/linux/percpu.h:47: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
include/linux/percpu.h:47: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
include/linux/percpu.h:47: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
In file included from include/linux/sched.h:596,
                 from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/asm/current.h: In function `get_current':
include/asm/current.h:11: warning: `current_thread_info' is deprecated (declared at include/asm/thread_info.h:95)
In file included from include/linux/module.h:10,
                 from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/sched.h: In function `on_sig_stack':
include/linux/sched.h:669: warning: `get_current' is deprecated (declared at include/asm/current.h:10)
include/linux/sched.h:669: warning: `get_current' is deprecated (declared at include/asm/current.h:10)
include/linux/sched.h: In function `sas_ss_flags':
include/linux/sched.h:674: warning: `get_current' is deprecated (declared at include/asm/current.h:10)
include/linux/sched.h:675: warning: `on_sig_stack' is deprecated (declared at include/linux/sched.h:668)
include/linux/sched.h: In function `capable':
include/linux/sched.h:685: warning: `get_current' is deprecated (declared at include/asm/current.h:10)
include/linux/sched.h:686: warning: `get_current' is deprecated (declared at include/asm/current.h:10)
include/linux/sched.h: In function `mmdrop':
include/linux/sched.h:702: warning: `atomic_dec_and_test' is deprecated (declared at include/asm/atomic.h:130)
include/linux/sched.h: In function `get_task_mm':
include/linux/sched.h:815: warning: `task_lock' is deprecated (declared at include/linux/sched.h:796)
include/linux/sched.h:819: warning: `task_unlock' is deprecated (declared at include/linux/sched.h:801)
include/linux/sched.h: In function `set_tsk_thread_flag':
include/linux/sched.h:830: warning: `set_ti_thread_flag' is deprecated (declared at include/linux/thread_info.h:56)
include/linux/sched.h: In function `clear_tsk_thread_flag':
include/linux/sched.h:835: warning: `clear_ti_thread_flag' is deprecated (declared at include/linux/thread_info.h:61)
include/linux/sched.h: In function `test_and_set_tsk_thread_flag':
include/linux/sched.h:840: warning: `test_and_set_ti_thread_flag' is deprecated (declared at include/linux/thread_info.h:66)
include/linux/sched.h: In function `test_and_clear_tsk_thread_flag':
include/linux/sched.h:845: warning: `test_and_clear_ti_thread_flag' is deprecated (declared at include/linux/thread_info.h:71)
include/linux/sched.h: In function `test_tsk_thread_flag':
include/linux/sched.h:850: warning: `test_ti_thread_flag' is deprecated (declared at include/linux/thread_info.h:76)
include/linux/sched.h: In function `set_tsk_need_resched':
include/linux/sched.h:855: warning: `set_tsk_thread_flag' is deprecated (declared at include/linux/sched.h:829)
include/linux/sched.h: In function `clear_tsk_need_resched':
include/linux/sched.h:860: warning: `clear_tsk_thread_flag' is deprecated (declared at include/linux/sched.h:834)
include/linux/sched.h: In function `signal_pending':
include/linux/sched.h:865: warning: `test_tsk_thread_flag' is deprecated (declared at include/linux/sched.h:849)
include/linux/sched.h: In function `need_resched':
include/linux/sched.h:870: warning: `test_thread_flag' is deprecated (declared at include/linux/thread_info.h:51)
include/linux/sched.h: In function `cond_resched':
include/linux/sched.h:877: warning: `need_resched' is deprecated (declared at include/linux/sched.h:869)
include/linux/sched.h: In function `cond_resched_lock':
include/linux/sched.h:891: warning: `need_resched' is deprecated (declared at include/linux/sched.h:869)
In file included from include/linux/device.h:21,
                 from drivers/eisa/eisa-bus.c:10:
include/linux/module.h: In function `__module_get':
include/linux/module.h:325: warning: `local_inc' is deprecated (declared at include/asm/local.h:17)
include/linux/module.h: In function `try_module_get':
include/linux/module.h:336: warning: `module_is_live' is deprecated (declared at include/linux/module.h:290)
include/linux/module.h:337: warning: `local_inc' is deprecated (declared at include/asm/local.h:17)
include/linux/module.h: In function `module_put':
include/linux/module.h:349: warning: `local_dec' is deprecated (declared at include/asm/local.h:25)
include/linux/module.h:351: warning: `module_is_live' is deprecated (declared at include/linux/module.h:290)
In file included from drivers/eisa/eisa-bus.c:17:
include/asm/io.h: In function `outb_local_p':
include/asm/io.h:363: warning: `outb_local' is deprecated (declared at include/asm/io.h:363)
include/asm/io.h:363: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `inb_local_p':
include/asm/io.h:363: warning: `inb_local' is deprecated (declared at include/asm/io.h:363)
include/asm/io.h:363: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `outb':
include/asm/io.h:363: warning: `outb_local' is deprecated (declared at include/asm/io.h:363)
include/asm/io.h: In function `inb':
include/asm/io.h:363: warning: `inb_local' is deprecated (declared at include/asm/io.h:363)
include/asm/io.h: In function `outb_p':
include/asm/io.h:363: warning: `outb' is deprecated (declared at include/asm/io.h:363)
include/asm/io.h:363: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `inb_p':
include/asm/io.h:363: warning: `inb' is deprecated (declared at include/asm/io.h:363)
include/asm/io.h:363: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `outw_local_p':
include/asm/io.h:364: warning: `outw_local' is deprecated (declared at include/asm/io.h:364)
include/asm/io.h:364: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `inw_local_p':
include/asm/io.h:364: warning: `inw_local' is deprecated (declared at include/asm/io.h:364)
include/asm/io.h:364: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `outw':
include/asm/io.h:364: warning: `outw_local' is deprecated (declared at include/asm/io.h:364)
include/asm/io.h: In function `inw':
include/asm/io.h:364: warning: `inw_local' is deprecated (declared at include/asm/io.h:364)
include/asm/io.h: In function `outw_p':
include/asm/io.h:364: warning: `outw' is deprecated (declared at include/asm/io.h:364)
include/asm/io.h:364: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `inw_p':
include/asm/io.h:364: warning: `inw' is deprecated (declared at include/asm/io.h:364)
include/asm/io.h:364: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `outl_local_p':
include/asm/io.h:365: warning: `outl_local' is deprecated (declared at include/asm/io.h:365)
include/asm/io.h:365: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `inl_local_p':
include/asm/io.h:365: warning: `inl_local' is deprecated (declared at include/asm/io.h:365)
include/asm/io.h:365: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `outl':
include/asm/io.h:365: warning: `outl_local' is deprecated (declared at include/asm/io.h:365)
include/asm/io.h: In function `inl':
include/asm/io.h:365: warning: `inl_local' is deprecated (declared at include/asm/io.h:365)
include/asm/io.h: In function `outl_p':
include/asm/io.h:365: warning: `outl' is deprecated (declared at include/asm/io.h:365)
include/asm/io.h:365: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
include/asm/io.h: In function `inl_p':
include/asm/io.h:365: warning: `inl' is deprecated (declared at include/asm/io.h:365)
include/asm/io.h:365: warning: `slow_down_io' is deprecated (declared at include/asm/io.h:286)
drivers/eisa/eisa-bus.c: In function `eisa_name_device':
drivers/eisa/eisa-bus.c:63: warning: `strcmp' is deprecated (declared at include/asm/string.h:100)
drivers/eisa/eisa-bus.c: In function `decode_eisa_sig':
drivers/eisa/eisa-bus.c:92: warning: `outb' is deprecated (declared at include/asm/io.h:363)
drivers/eisa/eisa-bus.c:94: warning: `inb' is deprecated (declared at include/asm/io.h:363)
drivers/eisa/eisa-bus.c: In function `eisa_bus_match':
drivers/eisa/eisa-bus.c:118: warning: `strlen' is deprecated (declared at include/asm/string.h:179)
drivers/eisa/eisa-bus.c:119: warning: `strcmp' is deprecated (declared at include/asm/string.h:100)
drivers/eisa/eisa-bus.c: In function `eisa_init_device':
drivers/eisa/eisa-bus.c:181: warning: `__constant_memcpy' is deprecated (declared at include/asm/string.h:214)
drivers/eisa/eisa-bus.c:181: warning: `__memcpy' is deprecated (declared at include/asm/string.h:192)
drivers/eisa/eisa-bus.c:183: warning: `inb' is deprecated (declared at include/asm/io.h:363)
drivers/eisa/eisa-bus.c: In function `eisa_probe':
drivers/eisa/eisa-bus.c:284: warning: `kmalloc' is deprecated (declared at include/linux/slab.h:97)
drivers/eisa/eisa-bus.c:289: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
drivers/eisa/eisa-bus.c:289: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
drivers/eisa/eisa-bus.c:289: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
drivers/eisa/eisa-bus.c:289: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
drivers/eisa/eisa-bus.c:320: warning: `kmalloc' is deprecated (declared at include/linux/slab.h:97)
drivers/eisa/eisa-bus.c:326: warning: `__constant_c_and_count_memset' is deprecated (declared at include/asm/string.h:404)
drivers/eisa/eisa-bus.c:326: warning: `__constant_c_memset' is deprecated (declared at include/asm/string.h:356)
drivers/eisa/eisa-bus.c:326: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
drivers/eisa/eisa-bus.c:326: warning: `__memset_generic' is deprecated (declared at include/asm/string.h:336)
make[2]: *** [drivers/eisa/eisa-bus.o] Error 1
make[1]: *** [drivers/eisa] Error 2
make: *** [drivers] Error 2

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_DOUBLEFAULT=y
CONFIG_IRQ_DEBUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_FULL_BUG=y
CONFIG_PANIC=y
CONFIG_FULL_PANIC=y
CONFIG_ELF_CORE=y
CONFIG_KCORE=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_PTRACE=y
CONFIG_VM86=y
CONFIG_DNOTIFY=y
CONFIG_AIO=y
CONFIG_SYSENTER=y
CONFIG_XATTR=y
CONFIG_FILE_LOCKING=y
CONFIG_DIRECTIO=y
CONFIG_POSIX_TIMERS=y
CONFIG_ETHTOOL=y
CONFIG_TCP_DIAG=y
CONFIG_INETPEER=y
CONFIG_NET_SK_FILTER=y
CONFIG_NET_DEV_MULTICAST=y
CONFIG_RTNETLINK=y
CONFIG_IGMP=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_CC_ALIGN_FUNCTIONS=1
CONFIG_CC_ALIGN_LABELS=1
CONFIG_CC_ALIGN_LOOPS=1
CONFIG_CC_ALIGN_JUMPS=1
CONFIG_SYSFS=y
CONFIG_FULL_STACK=y
CONFIG_CRC32_TABLES=y
CONFIG_INLINE_THREADINFO=y
CONFIG_INLINE_SEMAPHORE=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_MEMPOOL=y
CONFIG_FULLVT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BLOCK=y
CONFIG_MAX_SWAPFILES_SHIFT=5
CONFIG_NR_LDISCS=16
CONFIG_MAX_USER_RT_PRIO=100
CONFIG_HERTZ=1000
CONFIG_IDE_HWIFS=0
CONFIG_BOOTFLAG=y
CONFIG_SERIAL_PCI=y
CONFIG_PCI_QUIRKS=y
CONFIG_X86_TSC_TIMER=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX=y
CONFIG_CPU_SUP_NSC=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA=y
CONFIG_CPU_SUP_RISE=y
CONFIG_CPU_SUP_NEXGEN=y
CONFIG_CPU_SUP_UMC=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_M486=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_ACPI_BOOT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
CONFIG_I82092=y
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
CONFIG_BINFMT_ELF=y
CONFIG_FW_LOADER=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_PROBE_EISA_VL=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=8
CONFIG_AIC79XX_RESET_DELAY_MS=15000
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_SYN_COOKIES=y
CONFIG_BRIDGE=y
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_HAPPYMEAL=y
CONFIG_SUNGEM=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=y
CONFIG_EL2=y
CONFIG_ELPLUS=y
CONFIG_EL16=y
CONFIG_EL3=y
CONFIG_3C515=y
CONFIG_VORTEX=y
CONFIG_TYPHOON=y
CONFIG_LANCE=y
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=y
CONFIG_ULTRA=y
CONFIG_ULTRA32=y
CONFIG_SMC9194=y
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=y
CONFIG_NI52=y
CONFIG_NI65=y
CONFIG_AT1700=y
CONFIG_DEPCA=y
CONFIG_HP100=y
CONFIG_NET_ISA=y
CONFIG_E2100=y
CONFIG_EWRK3=y
CONFIG_EEXPRESS=y
CONFIG_EEXPRESS_PRO=y
CONFIG_HPLAN_PLUS=y
CONFIG_HPLAN=y
CONFIG_LP486E=y
CONFIG_ETH16I=y
CONFIG_NE2000=y
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
CONFIG_AMD8111_ETH=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_AC3200=y
CONFIG_APRICOT=y
CONFIG_B44=y
CONFIG_FORCEDETH=y
CONFIG_CS89x0=y
CONFIG_DGRS=y
CONFIG_EEPRO100=y
CONFIG_LNE390=y
CONFIG_FEALNX=y
CONFIG_NATSEMI=y
CONFIG_NE2K_PCI=y
CONFIG_NE3210=y
CONFIG_ES3210=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139_RXBUF_IDX=2
CONFIG_SIS900=y
CONFIG_EPIC100=y
CONFIG_SUNDANCE=y
CONFIG_TLAN=y
CONFIG_VIA_RHINE=y
CONFIG_ACENIC=y
CONFIG_DL2K=y
CONFIG_E1000=y
CONFIG_NS83820=y
CONFIG_HAMACHI=y
CONFIG_YELLOWFIN=y
CONFIG_R8169=y
CONFIG_SIS190=y
CONFIG_SK98LIN=y
CONFIG_TIGON3=y
CONFIG_IXGB=y
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_NET_RADIO=y
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PRISM54=m
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_NET_WIRELESS=y
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_PCIPS2=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_INTEL_MCH=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_DRM=y
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=y
CONFIG_FB=y
CONFIG_FB_MODES=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
CONFIG_FB_RIVA=m
CONFIG_FB_I810=m
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_VIA82XX=m
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_FS_POSIX_ACL=y
CONFIG_MINIX_FS=y
CONFIG_ROMFS_FS=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_CRAMFS=y
CONFIG_UFS_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_SMB_FS=m
CONFIG_CIFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

