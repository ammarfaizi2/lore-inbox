Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVDHOOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVDHOOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVDHOOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:14:05 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:19693 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262828AbVDHONz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:13:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cFFEkn4QIZxFSb2Dzmxgob83UdtxoryIkrZ8B+dFF3oKBKt5H/QmE0l8WHmqY1U8qIQ+ueg2FkwGapBKpCoVUxTGr6b9/mAe+UrWEQzaBRUyG4OexKBDWlFvxmi4en6vNLUGAZwRxvKAg5BtTQhelpgE8nj0Ntfr3YaGRsq0ECo=
Message-ID: <d120d50005040807135bd29429@mail.gmail.com>
Date: Fri, 8 Apr 2005 09:13:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Ali Akcaagac <aliakc@web.de>
Subject: Re: [BUG] 2.6.12-rc1/rc2 mouse0 became mouse1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112961492.1618.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1112961492.1618.3.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Apr 8, 2005 6:58 AM, Ali Akcaagac <aliakc@web.de> wrote:
> Hello,
> 
> This doesn't sound right to me. After upgrading from 2.6.11.5/6 to
> 2.6.12-rc1/rc2 I detected that my mouse didn't operate anymore when
> loading up XOrg, I realized that /dev/input/mouse0 (which worked for
> years) had to be changed to /dev/input/mouse1. Anyone care to explain
> why this had to be changed or what the intention behind this was ?
> 

Input devices names are not guaranteed to be stable, they get them in
order of their registration and therefore can change based on config,
order in which modules are loaded and changes in other modules. In
this case shift was caused by scroll support recently added to atkbd.

Ideally hotplug system should notify interested parties about current
layout, but for programs that do not support dynamic setup changes
please use mice multiplexor device (/dev/input/mice) that gives access
to data from _all_ mouse-like devices in the system.

Hope that helps.

-- 
Dmitry
