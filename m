Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317911AbSGWMnd>; Tue, 23 Jul 2002 08:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318049AbSGWMnd>; Tue, 23 Jul 2002 08:43:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:1811 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317911AbSGWMnc>;
	Tue, 23 Jul 2002 08:43:32 -0400
Message-ID: <3D3D4EE5.6040104@evision.ag>
Date: Tue, 23 Jul 2002 14:41:09 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 enum
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE421.3040800@evision.ag> <20020722160118.G6428@redhat.com> <20020723142704.B14323@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Jul 22, 2002 at 04:01:18PM -0400, Benjamin LaHaise wrote:
>  > On Mon, Jul 22, 2002 at 12:53:21PM +0200, Marcin Dalecki wrote:
>  > > - Fix a bunch of places where there are trailing "," at the
>  > >    end of enum declarations.
>  > 
>  > Please don't apply this.  By leaving the trailing "," on enums, additional 
>  > values can be added by merely inserting an additional + line in a patch, 
>  > otherwise there are excess conflicts when multiple patches add values to 
>  > the enum.
> 
> Gratuitous 'cleanups' with no real redeeming feature also have another
> downside which a lot of people seem to overlook.  They completely screws
> over anyone who also has a pending patch in that area if Linus applies it.
> 
> For most people this is five minutes work as they fix up by hand
> the single reject in one or two places.  For people like myself keeping
> a large patchset, this is a lot of extra work for absolutely no gain.
> Two kernels later, someone adds a new sysctl which re-adds the , at
> the end anyway.
> 
> We have much bigger problems to fix than silly[1] things like this.

Enabling -pedantic spotted me at least immediately at the
bug in readv/writev fixed in the same series of kernel without
resorting to LSB testing as Alan explained how he came across this
botch. So it's not entierly futile.

But for the enum case I agree that GCC is hossed and simply shouldn't
warn about it if in C99 mode. Personally I was just still thinking at 
C89 level. Well after all I already fixed this in the GCC I use.

And no matter what - there is not much working in the sysctl area and
non sized array forward declarations are not a nice thing both: to read 
and to the compiler. Same applies to the gratitious macro or ({ }) 
overusages in the other patches. Inlined functions how the advantage of
1. stricter type checking.
2. Possibly faster compilation(if only included by files which really 
use them of course)



