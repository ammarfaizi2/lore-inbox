Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUHMNye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUHMNye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUHMNye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:54:34 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:43712 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S265285AbUHMNxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:53:41 -0400
Date: Fri, 13 Aug 2004 15:52:33 +0200
From: Cornelia Huck <kernel@cornelia-huck.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Message-Id: <20040813155233.04ccac4a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20040813105412.GW13377@fs.tum.de>
References: <20040813101717.GS13377@fs.tum.de>
	<Pine.LNX.4.58.0408131231480.20635@scrub.home>
	<20040813105412.GW13377@fs.tum.de>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 12:54:12 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:

> It's also relatively safe since NET itself doesn't has any
> dependencies.

Otherwise, this would be problematic. Consider the following:

config FOO
        bool "foo"
        select BAR

config BAR
        bool
        depends on BAZ

config BAZ
        bool
        default n

You can select FOO, which will select BAR. In your config, you'll end up with
CONFIG_FOO=y
CONFIG_BAR=y
# CONFIG_BAZ is not set

(similar result if you don't specify BAZ at all), which would get you into trouble. (I saw this while looking into what happens if s390 uses drivers/Kconfig, and got a headache why some stuff was selected by
allyesconfig that depended on pci).

Question: Is this a bug or a feature? If the latter, select should probably not be used on anything that has dependencies...

Regards,
Cornelia
