Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWCHLh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWCHLh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWCHLh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:37:59 -0500
Received: from in.cluded.net ([195.159.29.203]:57527 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S964851AbWCHLh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:37:58 -0500
Message-ID: <440EC20D.3090004@cluded.net>
Date: Wed, 08 Mar 2006 11:37:49 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060307 SeaMonkey/1.5a
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org, raupach@nwfs1.rz.fh-hannover.de
Subject: Re: [Patch] Fix dead code in cdrom/gscd.c
References: <1141808871.6355.5.camel@alice>
In-Reply-To: <1141808871.6355.5.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn wrote:
> hi,
> 
> this fixes Coverity Bugs #21 and #22. In both cases the
> do { ... } while (result != 6 || result == 0x0E) just

This is completely wrong, and should be fixed too.

Either

	do { ... } while (result != 6)

is correct, or this is the result of a thinko, and it should be

	do { ... } while (result != 6 && result != 0x0E)

in which case your patch is incorrect.

> finishes for result == 6, so the if(result != 6) doesnt
> make much sense.

Unless its presence is an indication of faulty logic in the while clause


Daniel K.

