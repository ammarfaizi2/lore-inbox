Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSARRnx>; Fri, 18 Jan 2002 12:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290764AbSARRno>; Fri, 18 Jan 2002 12:43:44 -0500
Received: from [212.18.235.99] ([212.18.235.99]:25870 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S290767AbSARRn0>;
	Fri, 18 Jan 2002 12:43:26 -0500
From: Justin Cormack <kernel@street-vision.com>
Message-Id: <200201181743.g0IHhO226012@street-vision.com>
Subject: performance of O_DIRECT on md/lvm
To: linux-kernel@vger.kernel.org
Date: Fri, 18 Jan 2002 17:43:23 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading files with O_DIRECT works very nicely for me off a single drive 
(for video streaming, so I dont want cacheing), but is extremely slow on
software raid0 devices, and striped lvm volumes. Basically a striped 
raid device reads at much the same speed as a single device with O_DIRECT,
while reading the same file without O_DIRECT gives the expected performance
(but with unwanted cacheing).

raw devices behave similarly (though if you are using them you can probably
do your own raid0).

My guess is this is because of the md blocksizes being 1024, rather than
4096: is this the case and is there a fix (my quick hack at md.c to try
to make this happen didnt work).

Justin
