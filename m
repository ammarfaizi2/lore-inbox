Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131788AbRAYMfA>; Thu, 25 Jan 2001 07:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRAYMew>; Thu, 25 Jan 2001 07:34:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:14331 "HELO
	gus.distro.conectiva") by vger.kernel.org with SMTP
	id <S130008AbRAYMeq>; Thu, 25 Jan 2001 07:34:46 -0500
Date: Thu, 25 Jan 2001 10:38:45 -0200
From: "Luis Claudio R.Goncalves" <lclaudio@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: tiny patch for nfsd in 2.4.1-pre10
Message-ID: <20010125103845.A1077@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

   In order to get nfsd working I had to do this lill' trick. I'm not sure
this is truly necessary but it worked for me (tm) :)

-- 
[ Luis Claudio R. Goncalves                  lclaudio@conectiva.com.br ]
[ MSc coming soon -- Conectiva HA Team -- Gospel User -- Linuxer -- :) ]
[ Fault Tolerance - Real-Time - Distributed Systems - IECLB - IS 40:31 ]
[ LateNite Programmer --  Jesus Is The Solid Rock On Which I Stand  -- ]

--- linux-2.4.1-pre10.orig/fs/Config.in	Wed Jan 24 20:05:49 2001
+++ linux-2.4.1-pre10/fs/Config.in	Wed Jan 24 19:58:13 2001
@@ -91,13 +91,16 @@
       if [ "$CONFIG_NFS_FS" = "m" -o "$CONFIG_NFSD" = "m" ]; then
 	 define_tristate CONFIG_SUNRPC m
 	 define_tristate CONFIG_LOCKD m
-   else
+      else
 	 define_tristate CONFIG_SUNRPC n
 	 define_tristate CONFIG_LOCKD n
       fi
    fi
    if [ "$CONFIG_NFSD_V3" = "y" -o "$CONFIG_NFS_V3" = "y" ]; then
      define_bool CONFIG_LOCKD_V4 y
+   fi
+   if [ "$CONFIG_NFSD" = "m" ]; then
+      define_bool	 CONFIG_NFSD_MODULE y
    fi
 
    dep_tristate 'SMB file system support (to mount Windows shares etc.)' CONFIG_SMB_FS $CONFIG_INET
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
