Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUCKN7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUCKN7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:59:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:41901 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261263AbUCKN66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:58:58 -0500
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
From: "Yury V. Umanets" <umka@namesys.com>
To: Brad Laue <brad@brad-x.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40503120.9000008@brad-x.com>
References: <404F85A6.6070505@brad-x.com>
	 <20040310155712.7472e31c.akpm@osdl.org> <4050271C.3070103@brad-x.com>
	 <40503120.9000008@brad-x.com>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1079013607.24999.12.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 11 Mar 2004 16:00:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 11:28, Brad Laue wrote:
> Brad Laue wrote:
> > Hopefully the attached shows some irregularity. If not, I'll have to 
> > reply back in a few weeks when the problem recurs over the course of time.
> 
> And without further ado, the attachment. It's been a long day. :)
> 
> Brad
> 
> ______________________________________________________________________
> c0122bf0 current_kernel_time                           2   0.0312
> c0122d20 local_bh_enable                               2   0.0139
> c0137800 unlock_page                                   2   0.0208
> c013ef10 __kmalloc                                     2   0.0156
> c0155630 mark_buffer_dirty                             2   0.0250
> c0165760 poll_freewait                                 2   0.0250
> c01df2b0 xfs_ichgtime                                  2   0.0075
> c0202780 linvfs_get_block_core                         2   0.0027
> c0205310 linvfs_write                                  2   0.0069
> c0216e90 fast_copy_page                                2   0.0078
> c0244b90 tty_write                                     2   0.0030
> c0246020 tty_poll                                      2   0.0156
> c0248670 n_tty_receive_buf                             2   0.0005
> c024b1e0 pty_unthrottle                                2   0.0208
> c024b240 pty_write                                     2   0.0043
> c0109354 system_call                                   3   0.0682
> c0152e70 vfs_write                                     3   0.0099
> c0157cd0 alloc_buffer_head                             3   0.0312
> c01657b0 __pollwait                                    3   0.0144
> c016e100 dnotify_parent                                3   0.0156
> c01b1e50 xfs_bmapi                                     3   0.0006
> c024a3a0 normal_poll                                   3   0.0088
> c0107090 cpu_idle                                      4   0.0625
> c0153e60 fget                                          4   0.0625
> c0165c60 sys_select                                    4   0.0032
> c0216e30 fast_clear_page                               4   0.0417
> c0139280 generic_file_aio_write_nolock                 5   0.0019
> c0209d60 xfs_write                                     6   0.0028
> c011ba10 __wake_up                                     7   0.0729
> c0165960 do_select                                     8   0.0111
> c0249920 read_chan                                     9   0.0042
> c0156170 __block_prepare_write                        12   0.0117
> c02173c0 __copy_from_user_ll                          12   0.0938
> c010b570 handle_IRQ_event                             13   0.1161
> c0187210 write_profile                                14   0.2188
> c011b3c0 schedule                                     15   0.0107
> c0217350 __copy_to_user_ll                            47   0.4196
> c0122c80 do_softirq                                  136   0.8500
> c0107030 default_idle                               9222 192.1250
> 00000000 total            
Hello,

IMHO this does not look like profile results related to the problem. Or
it is inside big critical section with disabled irqs and profiler has no
hits there.

I guess it might be useful to try SysRq to catch the problem.

Do not forget to enable it in kernel config and run

echo "1" > /proc/sys/kernel/sysrq

then press Alt-SysRq-t when ksoftirqd starts to eat cpu time

This will dump a list of current tasks and their information to console.
Probably there will be some hint...

>                           9611   0.0063
-- 
umka

