Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQKTJDw>; Mon, 20 Nov 2000 04:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131396AbQKTJDl>; Mon, 20 Nov 2000 04:03:41 -0500
Received: from mailhost.opengroup.fr ([62.160.165.1]:65042 "EHLO
	mailhost.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S130155AbQKTJDZ>; Mon, 20 Nov 2000 04:03:25 -0500
Message-Id: <200011200832.JAA19770@mailhost.ri.silicomp.fr>
To: Guest section DW <dwguest@win.tue.nl>, Alexander Viro <viro@math.psu.edu>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] Inconsistent behaviour of rmdir 
In-Reply-To: Your message of Fri, 17 Nov 2000 15:27:31 -0500.
             <Pine.GSO.4.21.0011171514210.18150-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 20 Nov 2000 09:32:39 +0100
From: Eric Paire <paire@ri.silicomp.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 17 Nov 2000, Guest section DW wrote:
> 
> > I see that an entire discussion has taken place. Let me just remark this,
> > quoting the Austin draft:
> > 
> > If the path argument refers to a path whose final component is either
> > dot or dot-dot, rmdir( ) shall fail.
> > 
> > EINVAL	The path argument contains a last component that is dot.
> [snip]
> 
Then, I don't understand why the EINVAL error condition does not also include
dot-dot as last component.

> > So, it seems that -EINVAL would be a better return value in case LAST_DOT.
> 
> No problems with that... Linus, could you apply the following (cut-and-paste
> alert)?
> 
I think that there is another case where EINVAL (or EBUSY) should be more
relevant than ENOTEMPTY: consider a process invoking 'rmdir("..")' where "."
is empty and its current root directory (just because ".." and "." refer
to the same directory which is actually empty).

Anyway, thanks for your explainations on this special UNIX FS behaviour.
-Eric
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+ Eric PAIRE
Web  : http://www.ri.silicomp.com/~paire  | Groupe SILICOMP - Research Institute
Email: eric.paire@ri.silicomp.com         | 2, avenue de Vignate
Phone: +33 (0) 476 63 48 71               | F-38610 Gieres
Fax  : +33 (0) 476 51 05 32               | FRANCE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
