Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVDLJSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVDLJSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVDLJSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:18:03 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:62895 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S262073AbVDLJRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:17:54 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
To: Jamie Lokier <jamie@shareable.org>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Reply-To: 7eggert@gmx.de
Date: Tue, 12 Apr 2005 11:17:22 +0200
References: <3S8oM-So-11@gated-at.bofh.it> <3S8oM-So-13@gated-at.bofh.it> <3S8oN-So-15@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it> <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
> Miklos Szeredi wrote:

>>†††4)†Access†should†not†be†further†restricted†for†the†owner†of†the
>>††††††mount,†even†if†permission†bits,†uid†or†gid†would†suggest
>>††††††otherwise
>†
>†Why?††Surely†you†want†to†prevent†writing†to†files†which†don't†have†the
>†writable†bit†set?††A†filesystem†may†also†create†append-only†files†-
>†and†all†users†including†the†mount†owner†should†be†bound†by†that.

That†will†depend†on†the†situation.†If†the†user†is†mounting†a†tgz†owned
by†himself,†FUSE†should†default†to†being†a†convenient†hex-editor.

>>†††5)†As†much†of†the†available†information†should†be†exported†via†the
>>††††††filesystem†as†possible
>†
>†This†is†the†root†of†the†conflict.††You†are†trying†to†overload†the
>†permission†bits†and†uid/gid†to†mean†something†different†than†they
>†normally†do.
>†
>†While†it's†convenient†to†see†some†"remote"†information†such†as†the
>†uid/gid†in†a†tar†file,†are†you†sure†it's†a†good†idea†to†break†the†unix
>†permissions†model†-†which†will†break†some†programs?††(For†example,†try
>†editing†a†file†with†the†broken†semantics†in†an†editor†which†checks†the
>†uid/gid†of†the†file†against†the†current†user).

The†editor†will†try†to†keep†the†original†permissions,†and†saving†will†be
less†effective.

>>†††1)†Only†allow†mount†over†a†directory†for†which†the†user†has†write
>>††††††access†(and†is†not†sticky)
>†
>†Seems†good†-†but†why†not†sticky?††Mounting†a†user†filesystem†in
>†/tmp/user-xxx/my-mount-point†seems†not†unreasonable†-†provided†the
>†administrator†can†delete†the†directory†(which†is†possible†with
>†detachable†mount†points).

I†once†mounted†a†filesystem†in†~/tmp†after†forgetting†about†it†being†a
symlink†to†/tmp/$me/tmp,†and†I†had†to†promise†never†to†do†that†again.
Ng†zvqavtug,†gur†pyrnahc-grzc-fpevcg†xvpxrq†va.

>>†††5)†The†filesystem†daemon†is†free†to†fill†in†all†file†attributes†to
>>††††††any†(sane)†value,†and†the†kernel†won't†modify†these.
>†
>†Dangerous,†because†an†administrative†program†might†actually†trust†the
>†attributes†to†mean†what†they†normally†mean†in†the†unix†permissions†model.

The†same†risk†applies†to†smbmounted†file†systems.

Sane†daemons†will†do†no†check†besides†matching†the†owner†of†a†file†in†the
user's†home†against†the†expected†UID†and†checking†the†permission†mask,
since†you†can't†trust†users†not†to†mess†with†files†in†directories†they†own.
The†"best"†they†can†do†should†be†shoothing†their†own†feet.

(If†the†user†doesn't†own†the†directory,†FUSE†shouldn't†mount.)
--†
Top†100†things†you†don't†want†the†sysadmin†to†say:
80.†I†cleaned†up†the†root†partition†and†now†there's†LOTS†of†free†space.

Friﬂ,†Spammer:†customerservice@sister31.com†du0LCx6rst7@whitedoc.info
