Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWF0OMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWF0OMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWF0OMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:12:44 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:63802 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932316AbWF0OMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:12:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KbV0/IvkGheXtOoIMwFug6yaXu4lvdQlkZNjwNNJqCLZitgcNzx9/b9721Gau4wCOgUOllDNmbHiYcX8CwW/u+aIfOLuik9HnUNbL4Hp63IA10+n4Uz17jt4FOt0koUxtrLluk/kbvsPPJgDHzSEUeG9EJTrKU41dDms4DI1J+U=
Message-ID: <6bffcb0e0606270712w166f04a6u237d695e2bfa1913@mail.gmail.com>
Date: Tue, 27 Jun 2006 16:12:42 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm3
Cc: "Stephen Hemminger" <shemminger@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060627015211.ce480da6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/
>
>

It looks like a skge bug

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
---------------------------------------------------------
swapper/0 just changed the state of lock:
 (tasklist_lock){..-?}, at: [<c0128092>] send_group_sig_info+0x16/0x34
but this lock took another, soft-irq-unsafe lock in the past:
  (&sig->stats_lock){--..}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
no locks held by swapper/0.

the first lock's dependencies:
-> (tasklist_lock){..-?} ops: 13763 {
   initial-use  at:
                        [<c01353ab>] lock_acquire+0x60/0x80
                        [<c02d0ce2>] _write_lock_irq+0x29/0x38
                        [<c011c4e3>] copy_process+0xea7/0x13c0
                        [<c011cc6a>] do_fork+0x8d/0x18f
                        [<c010136c>] kernel_thread+0x6c/0x74
                        [<c0100518>] rest_init+0x14/0x3c
                        [<c03b6769>] start_kernel+0x388/0x390
                        [<c0100210>] 0xc0100210
   in-softirq-R at:
[..]

Here is a dmesg log http://www.stardust.webpages.pl/files/mm/2.6.17-mm3/mm-dmesg

Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.17-mm3/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
