Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTGOSBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbTGOSAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:00:31 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:26884 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S269128AbTGOR75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:59:57 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6 - sysfs sensor nameing inconsistency
Date: Tue, 15 Jul 2003 22:14:38 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307152214.38825.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4 all sensor chip got a subdirectory with name derived from type_name - a 
single word describing sensor, like

adm1021.c:              type_name = "max1617";
adm1021.c:              type_name = "max1617a";
adm1021.c:              type_name = "adm1021";
adm1021.c:              type_name = "adm1023";
adm1021.c:              type_name = "thmc10";
adm1021.c:              type_name = "lm84";
adm1021.c:              type_name = "gl523sm";
adm1021.c:              type_name = "mc1066";
...

etc. All user-level configuration (sensors, gkrellm) have been using these 
names to match available sensors and configuration data.

In 2.6 sensors appear under /sysfs, type_name no more used and the only 
identification available is .../name, but it seems to be arbitrary chosen 
like

- single word ("it87") - lm87.c
- "name chip" or "name subclient" - most others (lm78.c, wd83781d.c etc)
- completely arbitrary shiny description - "Generic LM85", "National LM85-B" 
etc in lm85.c

This means, any user program accessing sensors need incompatible changes and 
comfiuration cannot be shared between 2.4 and 2.6 without serious redesign 
and/or some translation layer.

If there are serious reasons to keep current names in "name" - what about 
adding extra type_name property that will hold type_name compatible with 2.4, 
at least for those drivers that are also available there. This would allow 
easily reuse existing sensors configuration.

TIA

-andrey
