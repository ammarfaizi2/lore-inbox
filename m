Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWFSQuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWFSQuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWFSQuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:50:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27287 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964795AbWFSQuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:50:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Preben Traerup <Preben.Trarup@ericsson.com>
Cc: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
	<m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
	<20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com>
	<m1y7vtia7r.fsf@ebiederm.dsl.xmission.com>
	<4496A677.3020301@ericsson.com>
Date: Mon, 19 Jun 2006 10:49:32 -0600
In-Reply-To: <4496A677.3020301@ericsson.com> (Preben Traerup's message of
	"Mon, 19 Jun 2006 15:28:23 +0200")
Message-ID: <m1hd2hhyzn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preben Traerup <Preben.Trarup@ericsson.com> writes:

> Strictly speaking for myself: Nothing.
>
> Mr. Akiyama Nobuyuk gave an example from his environment which is cluster
> systems.
> I was the one saying we in our Telco systems could use this feature too.
>
> The only thing Mr. Akiyama Nobuyuk and I have in common is we both would like to
> do
> something before crash dumping, simply because the less mess we will have to
> cleanup
> afterwards in the system taking over, the better.
>
> Mr. Akiyama Nobuyuk operates on SCSI devices to avoid filesystem corruptions.
> My usage would be more like notifying external management to get traffic
> redirected to server systems taking over.

Ok. That resolves some of my confusion.

After think this over here is my position.

There may be cases where it is warranted to add a call during crash_kexec.
I have seen no evidence that the cases where we want something happening
in crash_kexec are going to be at all common. It is my opinion anything
added to the crash_kexec path needs a case by case review.

Therefore if something is needs to happen in the crash kexec path it
should be a direct function call.  No pointers and no hooks.  Just call
the function.

Patches that and add an explicit function call allow for case by case review
and convey the message that you really don't want to do that, and that we
are really dealing with an exceptional circumstance.

Does this sound like a reasonable position?

Eric
