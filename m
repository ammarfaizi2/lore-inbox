Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSKMWfI>; Wed, 13 Nov 2002 17:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSKMWfI>; Wed, 13 Nov 2002 17:35:08 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:37785 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264625AbSKMWfH>; Wed, 13 Nov 2002 17:35:07 -0500
Date: Wed, 13 Nov 2002 14:45:12 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, rusty@rustcorp.com.au, kaos <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Message-id: <3DD2D5F8.5030102@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3DD2B1D5.7020903@pacbell.net> <20021113201710.GB7238@kroah.com>
 <3DD2B8D3.6060106@pacbell.net> <3DD2BD4C.7060502@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And it'd be handy if the text format for that information didn't change;
>> how it's stored in object modules doesn't matter.
> 
> Correction -- the tools that read the text format are buggy if they do 
> not transparently support changes to the text format.

That's not a correction, it's a tangent!   Either way, it's still
"handy" ... since supporting new formats requires new tools, and it's
clearly "handy" not to need to write, debug, and deploy new tools
(including teaching, documenting, etc).

> I am planning on adding PCI revision id to the information exported via 
> MODULE_DEVICE_TABLE(pci,...).  Tools which correctly read the 
> first-line-format-definition will continue to function as before, 
> regardless of additional fields I want to add.  Tools which make silly 
> assumptions will have those assumptions come back to bite them ;-)

The "silly assumption" seems to be that the current "modules.*map"
format can reasonably be extended ... when no rules for extending those
file formats were really defined, and the _only_ precedent for even
changing them involved incompatibility between "versions".

I'd far rather have a decent file format for that data, and move
away from that ungainly syntax, than try to retrofit rules about
how to extend that syntax.  Such a format should:

  - allow comments
  - not have as much garbage (zeroes, 0xffffffff, etc)
  - still be easily parsable from shell scripts (*)
  - be easier for site admins to edit (insert vi/emacs flamewar)
  - have an explicit version code, and rules about evolution

Alternatively, the tried'n'true approach of coupling the format
to the filename works:  don't reuse "modules.*map", use "*.modules"
or something.
- Dave

(*) This is the annoying requirement.  Maybe worth relaxing.
     For example, an XML format could easily support all the
     other requirements ... but not (AFAIK) that one.

