Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKGSup>; Tue, 7 Nov 2000 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129544AbQKGSuf>; Tue, 7 Nov 2000 13:50:35 -0500
Received: from TELOS.ODYSSEY.CS.CMU.EDU ([128.2.185.175]:27411 "EHLO
	telos.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S129505AbQKGSuT>; Tue, 7 Nov 2000 13:50:19 -0500
Date: Tue, 7 Nov 2000 13:48:42 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: mount -tcoda /dev/cfs0 /mnt no longer works in -test9 and newer?
Message-ID: <20001107134841.A31058@cs.cmu.edu>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001106103539.A343@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001106103539.A343@bug.ucw.cz>; from pavel@suse.cz on Mon, Nov 06, 2000 at 10:35:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 10:35:39AM +0100, Pavel Machek wrote:
> Hi!
> 
> It complains
> 
> coda_read_super: Bad mount data
> coda_read_super: device index: 0
> 
> and will not mount. What do I need to mount coda?
> 								Pavel

Miklos Szeredi sent a patch to support multiple mountpoints/coda
devices. However, the code falls back on the default device (cfs0)
when the mountdata is incorrect. So the problem must be unrelated
to the "Bad mount data" error message.

The code to mount with the correct mountdata looks like this:

      #include <linux/coda.h>

      muxfd = open("/dev/cfs0", O_RDWR);

      struct coda_mount_data mountdata;
      mountdata.version = CODA_MOUNT_VERSION;
      mountdata.fd = muxfd

      error = mount("coda", "/coda", "coda",  MS_MGC_VAL,
		    (void *)&mountdata);

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
