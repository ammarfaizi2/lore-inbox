Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130464AbRAIPpz>; Tue, 9 Jan 2001 10:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRAIPpf>; Tue, 9 Jan 2001 10:45:35 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:56998 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129561AbRAIPpY>; Tue, 9 Jan 2001 10:45:24 -0500
From: Christoph Rohland <cr@sap.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva>
	<20010109140932.E4284@redhat.com> <qwwhf387p4s.fsf@sap.com>
	<20010109153119.G9321@redhat.com>
Organisation: SAP LinuxLab
Date: 09 Jan 2001 16:45:10 +0100
In-Reply-To: "Stephen C. Tweedie"'s message of "Tue, 9 Jan 2001 15:31:19 +0000"
Message-ID: <qwwd7dw7mrd.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> On Tue, Jan 09, 2001 at 03:53:55PM +0100, Christoph Rohland wrote:
>> It's worse: The issue we are talking about is SYSV IPC_LOCK.
> 
> The issue is locked VA pages.  SysV is just one of the ways in which
> it can happen: the solution has got to address both that and
> mlock()/mlockall().

AFAIU mlock'ed pages would never get deactivated since the ptes do not
get dropped.

>> This is a per segment thing. A user can (un)lock a segment at any
>> time. But we do not have the references to the vmas attached to the
>> segemnts
> 
> Why not?  Won't the address space mmap* lists give you this?

OK. We could go from shmid_kernel->file->dentry->inode->mapping 
We had to scan all mappings for pages in the page tables and in the
page cache. Doesn't look really nice :-(

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
