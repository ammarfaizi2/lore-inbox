Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313566AbSDHG3t>; Mon, 8 Apr 2002 02:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313567AbSDHG3s>; Mon, 8 Apr 2002 02:29:48 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:7943 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S313566AbSDHG3r>; Mon, 8 Apr 2002 02:29:47 -0400
Date: Mon, 8 Apr 2002 09:27:37 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        John Levon <movement@marcelothewonderpenguin.com>,
        "Steven N. Hirsch" <shirsch@adelphia.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020408092737.D10733@actcom.co.il>
In-Reply-To: <E16uJHZ-0006eO-00@the-village.bc.nu> <20020407225504.Z10733@actcom.co.il> <E16uJHZ-0006eO-00@the-village.bc.nu> <20020407232339.B10733@actcom.co.il> <5.1.0.14.2.20020408000103.03cda5a0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 12:03:06AM +0100, Anton Altaparmakov wrote:
> At 21:23 07/04/02, Muli Ben-Yehuda wrote:

> >Right, this module (syscall_hijack.o) currently has the interface:
> >
> >int hijack_syscall_before(int syscall_id, func_ptr func);
> >int hijack_syscall_after(int syscall_id, func_ptr func);
> >
> >int release_syscall_before(int syscall_id);
> >int release_syscall_after(int syscall_id);
> >
> >where 'before' and 'after' correspond to a hook which should run
> >before the original system call is invoked (allowing it to specify
> >that the original system call should not be executed) or after the
> >original system call is invoked (allowing it access to its return
> >value).
> [snip]
> 
> So are you coping with someone hijacking YOU as well between calls to 
> hijack_syscall_* and release_syscall_*? Or would that trash the
> caller chain?

That should work fine, since we never explicitly refer to the entry in
the sys_call_table in our call chain (our callchain goes 

hijacked_function 
   -> hook_before
   if call original syscall
   ->  original syscall (the entry that was in the sys_call_table when we
       hijacked it, not the currrent entry!)
   -> hook_after

Note that we don't support stacking of hooks right now - we never had
need to. 
-- 
The ill-formed Orange
Fails to satisfy the eye:       http://vipe.technion.ac.il/~mulix/
Segmentation fault.             http://syscalltrack.sf.net/
