Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264072AbRFUAA2>; Wed, 20 Jun 2001 20:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264082AbRFUAAS>; Wed, 20 Jun 2001 20:00:18 -0400
Received: from spog.gaertner.de ([194.45.135.2]:15120 "EHLO spog.gaertner.de")
	by vger.kernel.org with ESMTP id <S264072AbRFUAAG>;
	Wed, 20 Jun 2001 20:00:06 -0400
Date: Thu, 21 Jun 2001 01:59:41 +0200 (MET DST)
Message-Id: <200106202359.BAA15009@aunt.gaertner.de>
From: Erik Schoenfelder <schoenfr@gaertner.de>
To: alan@clueserver.org
CC: linux-kernel@vger.kernel.org, jjciarla@raiz.uncu.edu.ar
In-Reply-To: <Pine.LNX.4.10.10106201608560.12664-100000@clueserver.org>
	(message from Alan Olsen on Wed, 20 Jun 2001 16:12:19 -0700 (PDT))
Subject: Re: IP_ALIAS in 2.4.x gone?
Reply-to: schoenfr@gaertner.de
In-Reply-To: <Pine.LNX.4.10.10106201608560.12664-100000@clueserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>>>> "Alan Olsen" == Alan Olsen <alan@clueserver.org> writes:

Alan Olsen> I found the problem...
Alan Olsen> IP_ALIAS is no longer needed in the config.  [...]
Alan Olsen> The documentation does not reflect that the alias
Alan Olsen> behaviour is on by default.

yes and sorry, you are absolutely right.  


Alan Olsen> I will submit a patch for the docs that reflects this so
Alan Olsen> others will not get confused by that.

great, this will surely help.  i've appended a first try how the
changes could be clarified.  please take this as a hopefully helpful
proposal (HHP for short ;-).

							Erik



--- linux-2.4.5/Documentation/networking/alias.txt-245	Tue Apr 28 23:22:04 1998
+++ linux-2.4.5/Documentation/networking/alias.txt	Thu Jun 21 01:41:45 2001
@@ -2,40 +2,43 @@
 IP-Aliasing:
 ============
 
+IP-aliases are additional IP-adresses/masks hooked up to a base 
+interface by adding a colon and a string when running ifconfig. 
+This string is usually numeric, but this is not a must.
+
+IP-Aliases are avail if CONFIG_INET (`standard' IPv4 networking) 
+is configured in the kernel.
 
-o For IP aliasing you must have IP_ALIAS support included by static
-  linking.
 
 o Alias creation.
-  Alias creation is done by 'magic' iface naming: eg. to create a
+  Alias creation is done by 'magic' interface naming: eg. to create a
   200.1.1.1 alias for eth0 ...
   
     # ifconfig eth0:0 200.1.1.1  etc,etc....
                    ~~ -> request alias #0 creation (if not yet exists) for eth0
-    and routing stuff also ...
-    # route add -host 200.1.1.1 dev eth0:0  (if same IP network as
-					    main device)
-   
-    # route add -net 200.1.1.0 dev eth0:0   (if completely new network wanted
-					    for eth0:0)
+
+    The corresponding route is also set up by this command. 
+    Please note: The route always points to the base interface.
+	
 
 o Alias deletion.
-  Also done by shutting the interface down:
+  The alias is removed by shutting the alias down:
 
     # ifconfig eth0:0 down
                  ~~~~~~~~~~ -> will delete alias
 
   		   		   
-Alias (re-)configuring
+o Alias (re-)configuring
 
-  Aliases are not real devices, but programs` should be able to configure and
+  Aliases are not real devices, but programs should be able to configure and
   refer to them as usual (ifconfig, route, etc).
 
-Relationship with main device
------------------------------
 
-  - the main device is an alias itself like additional aliases and can
-    be shut down without deleting other aliases.
+o Relationship with main device
+
+  If the base device is shut down the added aliases will be deleted 
+  too.
+
 
 Contact
 -------
