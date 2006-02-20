Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWBTPQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWBTPQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWBTPQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:16:23 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:62947 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1030271AbWBTPQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:16:22 -0500
Date: Mon, 20 Feb 2006 16:16:20 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060220151620.GB18841@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
	Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
	greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
	kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
	Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
References: <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <43F9B1F4.4040907@sw.ru> <20060220124103.GB17478@MAIL.13thfloor.at> <43F9D185.8020906@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9D185.8020906@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 05:26:13PM +0300, Kirill Korotaev wrote:
>> as does Linux-VServer currently, but do you have
>> any proof that putting all the fields together in
>> one big structure actually has any (dis)advantage
>> over separate structures?

> have no proof and don't mind if there are many pointers. 
> Though this doesn't look helpful to me as well.

well, my point is just that we don't know yet
so we should not favor one over the other, just
because somebody did it like that and it didn't
hurt :)

>>> mmm, how do you plan to pass additional flags to clone()?
>>> e.g. strong or weak isolation of pids?

>> do you really have to pass them at clone() time?
>> would shortly after be more than enough?
>> what if you want to change those properties later?

> I don't think it is always suiatable to do configuration later.
> We had races in OpenVZ on VPS create/stop against exec/enter etc. 
> (even introduced flag is_running). 
> So I have some experience to believe it will be painfull place.

well, Linux-VServer uses a state called 'setup'
which allows to change all kinds of things before
the guest can be entered, this state is changed
as the last operation of the setup, which in turn
drops all the capabilities and makes the guest
visible to the outside ...

works quite well and seems to be free of those
races you mentioned ...

>>> this syscalls will start handling this new namespace and that's all.
>>> this is not different from many syscalls approach.
>> well, let's defer the 'how amny syscalls' issue to
>> a later time, when we know what we want to implement :)
> agreed.

btw, maybe it's just me, but would it be possible
to do the email quoting like this:
 
 >>> Text

instead of

 > >>Text

TIA,
Herbert

> Kirill
