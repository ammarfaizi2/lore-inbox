Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270823AbRHXBVv>; Thu, 23 Aug 2001 21:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270822AbRHXBVl>; Thu, 23 Aug 2001 21:21:41 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:60173 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S270821AbRHXBVi>; Thu, 23 Aug 2001 21:21:38 -0400
Subject: [PATCH] Updated: Let net devices contribute entropy
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@alex.org.uk, miket@bluemug.com, cfriesen@nortelnetworks.com,
        riel@conectiva.com.br, laughing@shared-source.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 23 Aug 2001 21:21:45 -0400
Message-Id: <998616119.9306.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at:
http://tech9.net/rml/linux/patch-rml-2.4.9-netdev-random-1
http://tech9.net/rml/linux/patch-rml-2.4.9-netdev-random-2
for 2.4.9 (this is an update to the previous release), and:
http://tech9.net/rml/linux/patch-rml-2.4.8-ac10-netdev-random-1
http://tech9.net/rml/linux/patch-rml-2.4.8-ac10-netdev-random-2
for 2.4.8-ac10. Patch 1 contains the updated core code and patch 2
contains the updated drivers.  

What's New:
o 	_ALL_ network devices have been converted.  That is 159 drivers 	in
ac10.  Please help with patches if there are any missing 	drivers or
errors in the included drivers.
o	Updated the Configure.help entry to detail the situation where 	the
config option would endanger the entropy pool, per lklm 	discussion.
Thanks Alex	Bligh for the wording.
o	Resynced with the drivers in 2.4.9 and ac10 and the new archs in 	the
ac series.

For those who are new, this patch creates a new configure option which
enables network devices to contribute to /dev/random.  Previously, only
a few network devices feed the entropy pool.  With this patch, none do
until the config is set at which time they all can.

It works by defining a new request_irq flag, SA_SAMPLE_NET_RANDOM, which
when CONFIG_NET_RANDOM is set defines to SA_SAMPLE_RANDOM.

Previous discussions on this thread have hit on a lot of the issues
surronding this patch.  Currently, the opinion is: if an external
attacker can observe your network traffic precisely enough, they can
learn something of the state of your entropy pool, which would make the
entropy count an overestimate.  Now, however, the attacker will still
not be able to predict the output of /dev/random if the one-way hash
(SHA-1) remains unbreakable.  It has also been pointed out that it is
also important to seed /dev/random on bootup from the previous session
-- all distributions I know of do this.

Who is this for?  Users on systems with very low entropy, such as
headless or diskless systems _need_ a solution like this.  Some users
may be low on entropy, and do not like the 30s wait when SSH reads from
/dev/random -- this patch is for them, too.  Finally, there are users
like myself who don't fear attackers on their LAN and want more entropy
to feed their self esteem. :>

To install: apply the correct patches and enable the config option in
'Network Devices'.  Enjoy.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

