Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbTL3Jk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265705AbTL3Jk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:40:28 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:47246
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265698AbTL3JkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:40:23 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Software suspend in 2.6.0
Date: Tue, 30 Dec 2003 00:00:04 -0600
User-Agent: KMail/1.5.4
Cc: pavel@ucw.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312300000.05201.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Patrick fell off the face of the earth, I've switched to Pavel's suspend 
code, which pretty much works the same way, but has some similar rough edges.

The first suspend works nicely.  After resuming from that and suspending 
again, the screen gets blanked early in the suspend (immediately after 
"suspending processes", and then the suspend is REALLY SLOW.  (You can see 
the hard drive light light up and go off again with a 1/2 second gap between 
each page saved.)

I think that what's happening is that during the "power stuff down" phase, the 
device list is including the screen and processor and powering them down.  
The processor goes into an insanely slow state, and the display is black.  
(The suspend will usually complete normally when this happens, if you give it 
10 minutes.)

It doesn't do this on the first suspend, but it does it on second and later 
suspends.

Any suggestions?

Rob

