Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129240AbQKFTeF>; Mon, 6 Nov 2000 14:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129560AbQKFTdw>; Mon, 6 Nov 2000 14:33:52 -0500
Received: from ra.lineo.com ([204.246.147.10]:5311 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129148AbQKFTdi>;
	Mon, 6 Nov 2000 14:33:38 -0500
Message-ID: <3A07063C.612A225@Rikers.org>
Date: Mon, 06 Nov 2000 12:27:56 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <03da01c04816$8b178a30$650201c0@guidelet>  <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl> <6590.973530406@redhat.com> <8453.973531537@redhat.com>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/06/2000
 12:33:31 PM,
	Serialize complete at 11/06/2000 12:33:31 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could we handle this by setting a nomixerreset=1 option in modules.conf
or as the module default that would effect module reloads. Then on boot
up explicitly modprobe with a mixerlevel=0 and then set the levels via
aumix etc?

This way the existing hardware can keep the levels if it knows how. As
mentioned there would also have to be a setlevels user script called
after suspend/resume.

Barring this, we could create a persistantdata module that we can
modprobe and then discover with Keith's inter_module_xxx and read/write
opaque data to/from. Then if the user does not want to use it they can
just "alias persistantdata off" it and poof.

David Woodhouse wrote:
> 
> alonz@usa.net said:
> > The best solution to the sound driver issue, IMHO, is still entirely
> > userspace--- just no-one has written it yet. What we should do: 1.
> > Before auto-unload of the driver, run a small utility which will read
> > mixer settings
> >    and save them somewhere 2. When auto-loading the driver, use driver
> > arguments which are initialized from the
> >    settings saved above
> 
> That could work, although it may be better to make it more generic and
> capable of handling any form of data.
> 
> Any form of persistent storage would do - and if it can be handled entirely
> in userspace, all the better. I merely pointed out that Keith's
> inter_module_xxx could provide this quite cleanly. Others disputed that it
> was required at all.
> 
> --
> dwmw2
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
