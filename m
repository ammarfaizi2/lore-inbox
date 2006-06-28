Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423243AbWF1Jop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423243AbWF1Jop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWF1Jop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:44:45 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:33195 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030499AbWF1Joo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:44:44 -0400
Date: Wed, 28 Jun 2006 05:44:40 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lukas Jelinek <info@kernel-api.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
In-Reply-To: <44A1982C.1010008@kernel-api.org>
Message-ID: <Pine.LNX.4.58.0606280543270.32286@gandalf.stny.rr.com>
References: <44A1858B.9080102@kernel-api.org> <20060627132226.2401598e.rdunlap@xenotime.net>
 <44A1982C.1010008@kernel-api.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Lukas Jelinek wrote:

> Yes, here it is (it's really small and mindless):
>
> --- sed script begin ---
>
> /^\(\s\)*#endif/ {
> s/\/\*/\/\//
> s/\*\///
> }
>
> /^\(\s\)*\/\*.*\*\/\(\s\)*$/ {
> s/\/\*/\/\/\//
> s/\*\///
> }
>
> /^.*\/\*.*\*\/\(\s\)*$/ {
> s/\/\*/\/\/\/</
> s/\*\///
> }
>
> s/^\(\s\)*\/\*/\/\*\*\n/
>
> s/^.*\*\//\n\*\//
>
> --- sed script end ---
>

Here's a version that gets rid of a lot of confusing backslashes:

/^\(\s\)*#endif/ {
s,/\*,//,
s,\*/,,
}

\,^\(\s\)*/\*.*\*/\(\s\)*$, {
s,/\*,///,
s,\*/,,
}

\,^.*/\*.*\*/\(\s\)*$, {
s,/\*,///<,
s,\*/,,
}

s,^\(\s\)*/\*,/\*\*\n,

s,^.*\*/,\n\*/,


-- Steve

