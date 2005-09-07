Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVIGQlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVIGQlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVIGQlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:41:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14058 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751247AbVIGQls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:41:48 -0400
Subject: Re: [patch 4/4] ide: Break ide_lock -- remove ide_lock  from piix
	driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
In-Reply-To: <20050906234429.GE3642@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
	 <20050906234429.GE3642@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Sep 2005 18:06:23 +0100
Message-Id: <1126112783.8928.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-06 at 16:44 -0700, Ravikiran G Thirumalai wrote:
> Patch to convert piix driver to use per-driver/hwgroup lock and kill
> ide_lock.  In the case of piix, hwgroup->lock should be sufficient.

PIIX requires that both channels are quiescent when retuning in some
cases. It wasn't totally safe before, its now totally broken. Start by
fixing the IDE layer locking properly (or forward porting my patches and
then fixing them for all the refcounting changes and other stuff done
since).

Better yet move to the SATA driver - it can drive never PIIX chips in
PATA mode and its in my experience already more reliable.

Alan

