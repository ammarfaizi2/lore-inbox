Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbRFUMh1>; Thu, 21 Jun 2001 08:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbRFUMhR>; Thu, 21 Jun 2001 08:37:17 -0400
Received: from ns.suse.de ([213.95.15.193]:39432 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264717AbRFUMhH>;
	Thu, 21 Jun 2001 08:37:07 -0400
To: Ingo Rohloff <rohloff@in.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loop encryption module locking bug (linux-2.4.5).
In-Reply-To: <20010621135043.A13107@lxmayr6.informatik.tu-muenchen.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2001 14:36:58 +0200
In-Reply-To: Ingo Rohloff's message of "21 Jun 2001 13:55:33 +0200"
Message-ID: <ouppubyxb4l.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<sarcasm>
I think your mail is offtopic for linux-kernel: it doesn't mention Microsoft or user space
java programming or pointer to random unrelated web pages, but an actual kernel bug.
</sarcasm> 

Ingo Rohloff <rohloff@in.tum.de> writes:
> 
> If lo_open doesn't call the cipher lock function and 
> lo_release doesn't call the cipher unlock function, the issue
> is resolved. (So code gets deleted in the patch.)

I think it would be better if the low level module stays locked also while the 
control fd is open. That would match the semantics of most other devices.

Right fix probably is to call ->lock twice in loop_set_status()

[Also the locking is not SMP safe, but that's a different issue, for the e.g. ->lock
would need to be replaced with a struct module *owner and also some other locking]

-Andi
