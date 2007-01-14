Return-Path: <linux-kernel-owner+w=401wt.eu-S1751733AbXANX6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbXANX6N (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbXANX6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:58:13 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:35046 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbXANX6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:58:12 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=GgdAAs6iVScB0+4zTLyuHxE9QTa2op36gTQxpEEqKO4SAZBqMr3+jT0Gdf3OqSGsqM0hLAX1KvYiR63nAOrs3KuvrMG4wHO3ob9Ye8nCYcGdxJKZuBR2CKmTsNwNbJr6qVXDER8hkEjvL4e1NwCO7I21vSMEIXR0e2KX0Id7I/s=
Message-ID: <5166c2f30701141558td770dfbt13fd5098f76bcde6@mail.gmail.com>
Date: Sun, 14 Jan 2007 15:58:11 -0800
From: "Suhabe Bugrara" <suhabe@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: user pointer bugs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 45b8fa385ddf9fd9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In linux-2.6.19.2, do the following lines have bugs in them? It looks
like they dereference a user pointer without first being checked by
the "access_ok" macro to ensure that they point into userspace.

Suhabe

========================
File: sound/isa/sscape.c
Lines: 550, 665
Description: The pointer "bb" is dereferenced in the expression
"bb->code" without being checked first.
Fix: Replace "bb->code" with "&bb->code"

========================
File: block/scsi_ioctl.c
Lines: 406, 427, 430, 482, 486
Description: The pointer "sic" is dereferenced in the expression
"sic->data" without being checked first.
Fix: Replace "sic->code" with "&sic->code"

========================
File: sound/pci/rme9652/hdsp.c
Line: 4589
Description: The pointer "mixer" is dereferenced in the expression
"mixer->data" without being checked first.
Fix: Replace "mixer->matrix" with "&mixer->matrix"
