Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbUBWKge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 05:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUBWKgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 05:36:33 -0500
Received: from verein.lst.de ([212.34.189.10]:51915 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261906AbUBWKga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 05:36:30 -0500
Date: Mon, 23 Feb 2004 11:36:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org
Subject: Please back out the bluetooth sysfs support
Message-ID: <20040223103613.GA5865@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	marcel@holtmann.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch '[Bluetooth] Initial sysfs and device class support', is the
usual misguided sysfs conversion attempt levaing oopsable races, so
please back it out until the bluetooth folks have understood and cared
for the lifetime rule issues of using the driver model.

Guys, if you do use the driver model you have to adhere to it's life
time rules.  And that's most importantely you _must_ free the device
only in it's ->release routine.

And no, the code doesn't warn about the lack of a release method only
that everyone adds an empty one, sigh..
