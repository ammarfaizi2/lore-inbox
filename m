Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130820AbQK0CXV>; Sun, 26 Nov 2000 21:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132356AbQK0CXL>; Sun, 26 Nov 2000 21:23:11 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60432 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S130820AbQK0CW6>; Sun, 26 Nov 2000 21:22:58 -0500
Date: Sun, 26 Nov 2000 19:49:43 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: initdata for modules?
Message-ID: <20001126194943.F2265@vger.timpanogas.org>
In-Reply-To: <200011262347.PAA11866@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011262347.PAA11866@baldur.yggdrasil.com>; from adam@yggdrasil.com on Sun, Nov 26, 2000 at 03:47:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 03:47:30PM -0800, Adam J. Richter wrote:
> Keith Owens <kaos@ocs.com.au> wrote:
> >"Adam J. Richter" <adam@yggdrasil.com> wrote:
> >>	In reading include/linux/init.h, I was surprised to discover
> >>that __init{,data} expands to nothing when compiling a module.
> >>I was wondering if anyone is contemplating adding support for
> >>__init{,data} in module loading, to reduce the memory footprints
> >>of modules after they have been loaded.
> 
> >It has been discussed a few times but nothing was ever done about it.
> >AFAIK the savings were not seen to be that important because modules
> >occupy complete pages.  __init would have to be stored in a separate
> >page which was then discarded. [...]
> 
> 	No, you could just discard the part after the next page
> boundary.  The expected savings would be about the same, since
> the cases where the original code had just creeped over a page
> boundary in many cases would result in dropping more memory savings
> that the actual init size, from dropping those unused bytes
> between the very end of the init section and the end of that page.
> I say "about" the same becuase the distribution of text and data
> sizes is not uniformly random within some fixed interval.
> 
> 	Since you would not have to bump the start address of a
> section to the next page boundary, I wonder if it would still
> complicate insmod et al.
> 
> 	In case there is any confusion, I am not suggesting that
> this should go into the stock 2.4.0 releases.
> 
> 	However, I do find it helpful in allocating my time to
> cosider that saving one page by something like this or by enhancing
> gcc's variable placement saves as much space as 1024 eliminations
> of "= 0" or "= NULL" static variable initializations.


Microsoft drivers have an .INIT code section that is initialization 
ccode that get's chunked after it's loaded.  Their model allows 
memory segments to be defined as DISCARDABLE, which tells the loader
to chunk them after they get loaded in portable executable format.  

If ELF has something like it, perhaps it should go in the loader?

Jeff





> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
