Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWG3VyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWG3VyB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWG3VyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:54:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:31318 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932417AbWG3VyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:54:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=b8qEvpx0eZdsEgSdMUgsGKbG1FAc5/Qwm9k7oBWeEN1Eujni9fiS8kFKJYf2RdxO2Imxb49TirsuAOieSB0ln0oD6Q27e/Y9P5NCZR6rYSaevmEM2Vf2SvzPjjb5rxHbQxjJ7cuF8tin52xbxrlhor3zQzAztAW7OlGE1xjeAz4=
Date: Sun, 30 Jul 2006 23:52:57 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question about "Not Ready" SCSI error
Message-ID: <20060730215257.GA8339@leiferikson.dystopia.lan>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060730181014.GA13456@oscar.prima.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20060730181014.GA13456@oscar.prima.de>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Jul 30, 2006 at 08:10:19PM +0200, Patrick Mau wrote:
> Google revealed[1] that the drive is waiting for a START UNIT command,
> but it seems that the kernel is not attempting to spin up the drive
> again.

I don't know exactly if it's enough to requeue the scsi command, please
comment on this, guys.

Signed-off-by: Johannes Weiner <hnazfoo@gmail.com>

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="scsi_lib.patch"

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 077c1c6..545b900 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -913,6 +913,7 @@ void scsi_io_completion(struct scsi_cmnd
 			if (sshdr.asc == 0x04) {
 				switch (sshdr.ascq) {
 				case 0x01: /* becoming ready */
+				case 0x02: /* waiting for spin up */
 				case 0x04: /* format in progress */
 				case 0x05: /* rebuild in progress */
 				case 0x06: /* recalculation in progress */

--4SFOXa2GPu3tIq4H--
