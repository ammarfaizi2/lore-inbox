Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbRDDUWL>; Wed, 4 Apr 2001 16:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRDDUV5>; Wed, 4 Apr 2001 16:21:57 -0400
Received: from ns.suse.de ([213.95.15.193]:14601 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132396AbRDDUVE> convert rfc822-to-8bit;
	Wed, 4 Apr 2001 16:21:04 -0400
To: Tim Walberg <tewalberg@mediaone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/sched.c questions
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA028416D@MAINSERVER> <20010404150833.C28474@mediaone.net>
From: Andi Kleen <ak@suse.de>
Date: 04 Apr 2001 22:20:12 +0200
In-Reply-To: Tim Walberg's message of "4 Apr 2001 22:13:59 +0200"
Message-ID: <oupzodwxvr7.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Walberg <tewalberg@mediaone.net> writes:

> On 04/04/2001 16:52 -0300, Sardañons, Eliel wrote:
> >>	Hello, I would like to know why you put this two functions:
> >>	void scheduling_functions_start_here(void) { }
> >>	...
> >>	void scheduling_functions_end_here(void) { }
> >>	
> 
> That one I have no idea about - maybe some perverse sort
> of comment? Or maybe something somewhere needs to know the
> address range that some functions lie within, and these functions
> would delimit that range. Of course, that presumes that the
> compiler in use doesn't reorder functions in the object code
> that emits, but I think that's a fairly safe assumption for
> now...

This is needed for a very bad hack to get the EIP information in ps -lax:
most programs would be shown as hanging in schedule(), which would not be 
very useful to show the user. To avoid this sched.c is always compiled with 
frame pointers and if the EIP is inside these two functions the proc code 
goes back one level in the stack frame.


-Andi
