Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbUL3BNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbUL3BNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUL3BNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:13:04 -0500
Received: from hera.kernel.org ([209.128.68.125]:29843 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261470AbUL3BNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:13:01 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: wrong hardlink count for /proc/PID directories
Date: Thu, 30 Dec 2004 01:12:11 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cqvklb$70t$1@terminus.zytor.com>
References: <20041222221623.GA706@cs.bme.hu> <Pine.LNX.4.61.0412222340540.475@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1104369131 7198 127.0.0.1 (30 Dec 2004 01:12:11 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 30 Dec 2004 01:12:11 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0412222340540.475@yvahk01.tjqt.qr>
By author:    Jan Engelhardt <jengelh@linux01.gwdg.de>
In newsgroup: linux.dev.kernel
> 
> You could try working around this by using -noleaf. (Which is by no means a 
> solution.)
> 
> Hm, I have 2.6.8+.9-rc2, and /proc/1 for example has a link count of 3 which 
> seems reasonable: ".", "fd" and "task".
> 

You're missing "attr", and you're not counting the directory entry
from below.

directory + "." + "attr/.." + "fd/.." + "task/.." = 5.

It should either return the correct value or set it to 1.

	-hpa
