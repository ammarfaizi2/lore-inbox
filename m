Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290769AbSARRvX>; Fri, 18 Jan 2002 12:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290770AbSARRvN>; Fri, 18 Jan 2002 12:51:13 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:27328 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290769AbSARRvH>; Fri, 18 Jan 2002 12:51:07 -0500
Message-ID: <3C48607C.35D3DDFF@redhat.com>
Date: Fri, 18 Jan 2002 17:50:53 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Cormack <kernel@street-vision.com>, linux-kernel@vger.kernel.org
Subject: Re: performance of O_DIRECT on md/lvm
In-Reply-To: <200201181743.g0IHhO226012@street-vision.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> 
> Reading files with O_DIRECT works very nicely for me off a single drive
> (for video streaming, so I dont want cacheing), but is extremely slow on
> software raid0 devices, and striped lvm volumes. Basically a striped
> raid device reads at much the same speed as a single device with O_DIRECT,
> while reading the same file without O_DIRECT gives the expected performance
> (but with unwanted cacheing).
> 
> raw devices behave similarly (though if you are using them you can probably
> do your own raid0).
> 
> My guess is this is because of the md blocksizes being 1024, rather than
> 4096: is this the case and is there a fix (my quick hack at md.c to try
> to make this happen didnt work).

well not exactly. Raid0 is faster due to readahead (eg you read one
block and the kernel 
sets the OTHER disk also working in parallel in anticipation of you
using that). O_DIRECT
is of course directly in conflict with this as you tell the kernel that
you DON'T want
any optimisations....

Greetinsg,
  Arjan van de Ven
