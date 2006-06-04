Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932315AbWFDX2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWFDX2v (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWFDX2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:28:50 -0400
Received: from smtp.ono.com ([62.42.230.12]:62639 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932318AbWFDX2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:28:50 -0400
Date: Mon, 5 Jun 2006 01:28:42 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605012842.3d58095f@werewolf.auna.net>
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.2.0cvs82 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2006 23:20:04 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
> 
> - Lots of PCI and USB updates
> 
> - The various lock validator, stack backtracing and IRQ management problems
>   are converging, but we're not quite there yet.
> 

I got this with -mm2, is it supposed to be cured in -mm3 ? I still have to
try with mm3:

Jun  2 14:34:39 annwn kernel: Console: colour VGA+ 80x60
Jun  2 14:34:39 annwn kernel: ------------------------
Jun  2 14:34:39 annwn kernel: | Locking API testsuite:
Jun  2 14:34:39 annwn kernel: ----------------------------------------------------------------------------
Jun  2 14:34:39 annwn kernel:                                  | spin |wlock |rlock |mutex | wsem | rsem |
Jun  2 14:34:39 annwn kernel:   --------------------------------------------------------------------------
Jun  2 14:34:39 annwn kernel:                      A-A deadlock:failed|failed|failed|failed|failed|failed|
Jun  2 14:34:39 annwn kernel:                  A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
Jun  2 14:34:39 annwn kernel:              A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
Jun  2 14:34:39 annwn kernel:              A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
Jun  2 14:34:39 annwn kernel:          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
Jun  2 14:34:39 annwn kernel:          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
Jun  2 14:34:39 annwn kernel:          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
Jun  2 14:34:39 annwn kernel:                     double unlock:failed|failed|failed|failed|failed|failed|
Jun  2 14:34:39 annwn kernel:                  bad unlock order:failed|failed|failed|failed|failed|failed|
Jun  2 14:34:39 annwn kernel:   --------------------------------------------------------------------------
Jun  2 14:34:39 annwn kernel:               recursive read-lock:             |  ok  |             |failed|
Jun  2 14:34:39 annwn kernel:   --------------------------------------------------------------------------
Jun  2 14:34:39 annwn kernel:      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
Jun  2 14:34:39 annwn kernel:      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
Jun  2 14:34:39 annwn kernel:      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
Jun  2 14:34:39 annwn kernel:      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
Jun  2 14:34:39 annwn kernel:        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
Jun  2 14:34:39 annwn kernel:        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
Jun  2 14:34:39 annwn kernel:          hard-safe-A + irqs-on/12:failed|failed|  ok  |
Jun  2 14:34:39 annwn kernel:          soft-safe-A + irqs-on/12:failed|failed|  ok  |

(all tests failed like this...)

Jun  2 14:34:39 annwn kernel: --------------------------------------------------------
Jun  2 14:34:39 annwn kernel: 141 out of 206 testcases failed, as expected. |
Jun  2 14:34:39 annwn kernel: ----------------------------------------------------

Expected ? Uh ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.16-jam18 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Mon
