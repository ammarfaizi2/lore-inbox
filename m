Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271371AbRIGGVu>; Fri, 7 Sep 2001 02:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271399AbRIGGVk>; Fri, 7 Sep 2001 02:21:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58122 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271371AbRIGGVY>; Fri, 7 Sep 2001 02:21:24 -0400
Message-ID: <3B986767.1080203@zytor.com>
Date: Thu, 06 Sep 2001 23:21:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <9n8ev1$qba$1@cesium.transmeta.com> <3B985FC6.B41000A3@candelatech.com> <20010907102605.A26028@castle.nmd.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> 
> It will work almost always, except cases where administrator set different
> preffered sources in local routes.
> I.e. it is indeed a very good approximation, but autofs shouldn't still hang
> or do nasty things if the check with the datagram socket shows that address
> isn't local, but in reality it happens to be local.
> A subtle misbehavior or loss of efficiency are acceptable, in my opinion.
> 
> Theoretically, it might be possible to create a configuration which gives
> false positive in this check, but I can't see how it may be harmful...
> 

If the check gives a false negative, autofs will create an NFS mount 
even though it's a local file (which may fail if the filesystem isn't 
exported, and is definitely slower.)

If the check gives a false positive, it will try a local bind (and 
probably fail) even though it is a remote filesystem.

	-hpa

