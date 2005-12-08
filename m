Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVLHVPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVLHVPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVLHVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:15:00 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:44587 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932389AbVLHVO7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:14:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I1wX5btUue2oKHpsEuBGJbF/Ovk8NvTGfPLp5gnL6TU3cRutQFRGUFhJm7y4Gjz7slbg4xCN/oxzHJ+d8tBB2xjqT7x8o1Bk0Cv7ikOescInlVg368vag6G9IoFqgpdA3TYGWhLS3WTheJF6h6txSDcWfh7hYaIXyv9Y+gMeGv4=
Message-ID: <d120d5000512081314r6b574eb3jf5516ef5bc28730d@mail.gmail.com>
Date: Thu, 8 Dec 2005 16:14:58 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: LKML <linux-kernel@vger.kernel.org>
Subject: Driver bind/unbind and __devinit
Cc: Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Many drivers have their probe routines declared as __devinit which is
a no-op unless CONFIG_HOTPLUG is set. However driver's bind/unbind
attributes are created unconditionally, as fas as I can see. Would not
it cause an oops if someone tries to use these attributes with
CONFIG_HOTPLUG=N? Am I missing something?

Also, unbind implementation does not seem safe - we check the driver
before taking device's semaphore so we risk unbinding wrong driver (in
the unlikely event that we manage to unbind and bind another driver in
another thread).

--
Dmitry
