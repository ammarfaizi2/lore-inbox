Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTBUFND>; Fri, 21 Feb 2003 00:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTBUFND>; Fri, 21 Feb 2003 00:13:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:34491 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267145AbTBUFNA>;
	Fri, 21 Feb 2003 00:13:00 -0500
Date: Thu, 20 Feb 2003 21:24:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: effect of streaming write on interactivity
Message-Id: <20030220212439.1a103a44.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:23:01.0175 (UTC) FILETIME=[4D511C70:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It peeves me that if a machine is writing heavily, it takes *ages* to get a
login prompt.

Here we start a large streaming write, wait for that to reach steady state
and then see how long it takes to pop up an xterm from the machine under
test with

	time ssh testbox xterm -e true

there is quite a lot of variability here.

2.4.21-4:	62 seconds
2.5.61+hacks:	14 seconds
2.5.61+CFQ:	11 seconds
2.5.61+AS:	12 seconds

