Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKAQea>; Wed, 1 Nov 2000 11:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQKAQeJ>; Wed, 1 Nov 2000 11:34:09 -0500
Received: from smtp-abo-1.wanadoo.fr ([193.252.19.122]:55223 "EHLO
	villosa.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129026AbQKAQeB>; Wed, 1 Nov 2000 11:34:01 -0500
Date: Wed, 1 Nov 2000 17:43:39 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, riel@nl.linux.org, andrea@e-mind.com
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001101174339.A1167@bylbo.nowhere.earth>
In-Reply-To: <20001101133307.A10265@bylbo.nowhere.earth> <Pine.LNX.4.21.0011010940450.2774-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011010940450.2774-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Nov 01, 2000 at 09:41:04AM -0200
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 09:41:04AM -0200, Marcelo Tosatti wrote:
> VM-global It should fix your problem. 

Thanks for the hint, it works great indeed, I couldn't freeze the machine
any more - at least the make process understood Ctrl-C.

However, the OOM killer behaves in strange ways, it seems.  In the 2 "make
-j50" runs I had (one with the working fs mounted 'sync', the other
'async'), it mostly killed non-root processes, but once it killed 'cron',
which was run as root:

[sync run]
Nov  1 15:51:05 bylbo kernel: VM: killing process cpp
Nov  1 15:56:38 bylbo kernel: VM: killing process apache
Nov  1 16:02:54 bylbo kernel: VM: killing process cc1
Nov  1 16:08:51 bylbo kernel: VM: killing process wwwoffled

[async run]
Nov  1 17:13:08 bylbo kernel: VM: killing process apache
Nov  1 17:14:01 bylbo kernel: VM: killing process cron


apache was running as "www-data" (uid 33), wwwoffled as "proxy" (uid 13).

An idea that came upon me was whether it would be possible to add to the
OOMK some sort of preference for processes owned by "system users", to be
defined by a "uid limit".  For example, on Debian systems, where "real user"
uids start at 1000, it would be great if the OOMK would leave those
processes as far as possible off its kill list.  Opinions ?

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
debian-email:   <dirson@debian.org> |   Support Debian GNU/Linux:
                                    | Cheaper, more Powerful, more Stable !
http://ydirson.free.fr/             | Check <http://www.debian.org/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
