Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTFYLvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTFYLvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 07:51:31 -0400
Received: from [81.2.110.254] ([81.2.110.254]:59642 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262872AbTFYLv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 07:51:27 -0400
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Dillow <dave@thedillows.org>
Cc: Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1056513292.3885.2.camel@ori.thedillows.org>
References: <1056493150.2840.17.camel@ori.thedillows.org>
	 <20030624204828.I30001@newbox.localdomain>
	 <1056513292.3885.2.camel@ori.thedillows.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056542418.2460.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jun 2003 13:00:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its a known problem. There are two approaches. Either rewrite the ide
scsi reset code to use ide_abort infrastructure or switch ide-scsi back
to the old abort/reset code not new_eh and use SCSI_RESET_PUNT so that
the recovery is all handled by the ide layer.

For 2.4 the latter may be the best approach, for 2.5 it has to use
new_eh

