Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277721AbRJMKCE>; Sat, 13 Oct 2001 06:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277693AbRJMKBz>; Sat, 13 Oct 2001 06:01:55 -0400
Received: from zero.aec.at ([195.3.98.22]:58385 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S277656AbRJMKBr>;
	Sat, 13 Oct 2001 06:01:47 -0400
To: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Subject: Re: crc32 cleanups
In-Reply-To: <Pine.LNX.4.30.0110131131200.32076-100000@stud.fbi.fh-darmstadt.de>
From: Andi Kleen <ak@muc.de>
Date: 13 Oct 2001 12:02:16 +0200
In-Reply-To: Jan-Marek Glogowski's message of "Sat, 13 Oct 2001 11:48:11 +0200 (CEST)"
Message-ID: <k2het3luxj.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0110131131200.32076-100000@stud.fbi.fh-darmstadt.de>,
Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de> writes:
> Comments

Just use the existing linker features. Link the crc code as an .a library.
If some code needs it it'll get included. If it needs initialization 
use the existing __initcall() setup. It'll generate a call to the 
initialization function when it is linked in, and none if it is not.

[Note that __initcall may be a bit tricky here if some other __initcall
user like an ethernet driver needs crc32 too; there is unfortunately no
priority mechanism in __initcall to enforce that the crc32 init runs before
the other initcalls. best would probably just to use a static table to avoid 
this issue] 

-Andi
