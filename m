Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130126AbQKIScn>; Thu, 9 Nov 2000 13:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbQKIScd>; Thu, 9 Nov 2000 13:32:33 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:42763 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129091AbQKISc2>;
	Thu, 9 Nov 2000 13:32:28 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jan Kara <jack@suse.cz>
Date: Thu, 9 Nov 2000 19:31:48 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Used space in bytes
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <C61D06525A1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Nov 00 at 19:18, Jan Kara wrote:
> used (I tried to contact Ulrich Drepper <drepper@redhat.com> who should
> be right person to ask about such things (at least I was said so) but go
> no answer...). Does anybody have any better solution?
>   I know about two others - really ugly ones:
>    1) fs specific ioctl()
>    2) compute needed number of bytes from st_size and st_blocks, which is
>       currently possible but won't be in future

If I may, please do not add it into stat/stat64 structure. On Netware, 
computing really used space can take eons because of it has to read 
allocation tables to memory to find size. It is usually about 500% 
slower than retrieving all other file informations.

Or at least add some parameter to stat so that filesystem can say which
informations are important for you. But I think that ioctl is less
ugly. But that's just my opinion and I know that others here are strongly
against ioctl.
                                           Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
