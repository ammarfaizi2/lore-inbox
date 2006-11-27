Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758359AbWK0QUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359AbWK0QUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbWK0QUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:20:05 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:43923 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1758359AbWK0QUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:20:03 -0500
Message-ID: <456B101D.3040803@nortel.com>
Date: Mon, 27 Nov 2006 10:19:41 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: G.Ohrner@post.rwth-aachen.de, linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr> <ek54hf$icj$2@sea.gmane.org> <456B0F53.90209@cfl.rr.com>
In-Reply-To: <456B0F53.90209@cfl.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 16:19:48.0281 (UTC) FILETIME=[DBC68A90:01C7123F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:

> I ran into this the other day myself and when I investigated the kernel 
> code, I found that writes to /dev/random do accept the data into the 
> entropy pool, but do NOT update the entropy estimate.  In order to do 
> that, you have to use a root only ioctl to add the data and update the 
> estimate.  I am not sure why this is, or if there is a tool already 
> written somewhere to use this ioctl, maybe someone else can comment?

I believe the idea was that you don't want random users being able to 
artificially inflate your entropy count.  So the kernel tries to make 
use of entropy entered by regular users (by stirring it into the pool) 
but it doesn't increase the entropy estimate unless root says its okay.

Chris
