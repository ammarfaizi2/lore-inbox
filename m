Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSJLHrE>; Sat, 12 Oct 2002 03:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbSJLHrE>; Sat, 12 Oct 2002 03:47:04 -0400
Received: from chunk.voxel.net ([207.99.115.133]:2228 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S262208AbSJLHrD>;
	Sat, 12 Oct 2002 03:47:03 -0400
Date: Sat, 12 Oct 2002 03:52:55 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Linux v2.5.42
Message-ID: <20021012075255.GA10000@chunk.voxel.net>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

esp.c got mangled; fixed to allow compilation are attached.  Please
consider LVM2 inclusion; it co-exists happily LVM1, is a much cleaner 
driver than LVM1, and is well tested (at least under 2.4).


On Fri, Oct 11, 2002 at 09:59:58PM -0700, Linus Torvalds wrote:
> 
> 
> Augh.. People have been mailbombing me apparently because a lot of people 
> finally decided that they really want to sync with me due to the upcoming 
> feature freeze, so there's a _lot_ of stuff here, all over the map.
> 
> Both the NFS client and the server are getting facelifts to support NFSv4.
> And both Dave Jones and Alan Cox decided to try to merge more stuff with
> me - along with the usual stream from Andrew Morton.
> 
> In addition, we have build updates, ISDN, ACPI, input layer, network
> drivers and driverfs.. Along with a random collection of other stuff: USB,
> s390, ppc etc.
> 
> End result: 1MB worth of compressed patches - in four days. 
> 
> 			Linus
> 
> 
> PS: NOTE - I'm not going to merge either EVMS or LVM2 right now as things
> stand.  I'm not using any kind of volume management personally, so I just
> don't have the background or inclination to walk through the patches and
> make that kind of decision. My non-scientific opinion is that it looks 
> like the EVMS code is going to be merged, but ..
> 
> Alan, Jens, Christoph, others - this is going to be an area where I need
> input from people I know, and preferably also help merging. I've been 
> happy to see the EVMS patches being discussed on linux-kernel, and I just 
> wanted to let people know that this needs outside help.
> 
> ----
> 
> Summary of changes from v2.5.41 to v2.5.42
> ============================================
[...]
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="esp.diff"

--- a/drivers/scsi/esp.c	2002-10-12 03:09:47.000000000 -0400
+++ b/drivers/scsi/esp.c	2002-10-12 03:23:25.000000000 -0400
@@ -1576,7 +1576,6 @@
 		memset(esp_dev, 0, sizeof(struct esp_device));
 		SDptr->hostdata = esp_dev;
 	}
-	}
 
 	esp->snip = 0;
 	esp->msgout_len = 0;
@@ -3589,7 +3588,7 @@
 				     Scsi_Cmnd *SCptr,
 				     struct esp_device *esp_dev)
 {
-	if (esp_dev->sync || SCptr->SDptr->borken) {
+	if (esp_dev->sync || SCptr->device->borken) {
 		/* sorry, no can do */
 		ESPSDTR(("forcing to async, "));
 		build_sync_nego_msg(esp, 0, 0);
@@ -3811,7 +3810,7 @@
 
 			/* Regardless, next try for sync transfers. */
 			build_sync_nego_msg(esp, esp->sync_defp, 15);
-			espo_dev->sync = 1;
+			esp_dev->sync = 1;
 			esp->snip = 1;
 			message_out = EXTENDED_MESSAGE;
 		}

--wRRV7LY7NUeQGEoC--
