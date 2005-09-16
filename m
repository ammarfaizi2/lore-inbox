Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVIPWWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVIPWWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVIPWWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:22:25 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:26759 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750727AbVIPWWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:22:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=B8l9f2UrG8DrqO0ljP5MTmmgRYCcnuS26MmXx1937LNK9ZcezBFh9XDbEt58HEC/K1BBvufTLXScrIkOnL4kOBe9E8HNVFffjZ3v/8AHj3stmn5nXwmH7EMxhC2ArXydU11k36vC93pSrkxNQBu9OJ2vF7bCuitLFgwk2tM99gI=
Date: Sat, 17 Sep 2005 02:32:33 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Documentation/ioctl-mess.txt: start annotating ("I: ", "O: ")
Message-ID: <20050916223233.GA6515@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Annotate ~25% of the list. For now, format is:

	N: NAME
	I: data copied from userspace by copy_from_user()/get_user(), or
		"I: (type) arg", or
		"I: -".
	O: data copied to userspace by copy_to_user()/put_user(), or
		"O: -".

Also:
* Update Documentation/00-INDEX
* Some numbers found their names
* Add a couple of new ioctls

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/00-INDEX       |    2 
 Documentation/ioctl-mess.txt | 2437 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 1983 insertions(+), 456 deletions(-)

diff -uprN linux-2.6.14-rc1-mm1-vanilla/Documentation/00-INDEX linux-2.6.14-rc1-mm1-ioctl-mess.txt/Documentation/00-INDEX
--- linux-2.6.14-rc1-mm1-vanilla/Documentation/00-INDEX	2005-09-16 21:26:57.000000000 +0400
+++ linux-2.6.14-rc1-mm1-ioctl-mess.txt/Documentation/00-INDEX	2005-09-16 21:28:49.000000000 +0400
@@ -128,6 +128,8 @@ input/
 	- info on Linux input device support.
 io_ordering.txt
 	- info on ordering I/O writes to memory-mapped addresses.
+ioctl-mess.txt
+	- tree-wide ioctl registry.
 ioctl-number.txt
 	- how to implement and register device/driver ioctl calls.
 iostats.txt
diff -uprN linux-2.6.14-rc1-mm1-vanilla/Documentation/ioctl-mess.txt linux-2.6.14-rc1-mm1-ioctl-mess.txt/Documentation/ioctl-mess.txt
--- linux-2.6.14-rc1-mm1-vanilla/Documentation/ioctl-mess.txt	2005-09-16 21:28:03.000000000 +0400
+++ linux-2.6.14-rc1-mm1-ioctl-mess.txt/Documentation/ioctl-mess.txt	2005-09-17 02:17:06.000000000 +0400
@@ -6,78 +6,259 @@ ioctl-mess.txt maintainer (see MAINTAINE
 time for patch-cooking, simple "there is SIOCGPIZZA ioctl" notice via email
 would also be fine.
 
-Please, keep the list in alphabetical order.
+N: NAME
+I: data copied from userspace by copy_from_user()/get_user(), or
+	"I: (type) arg", or
+	"I: -".
+O: data copied to userspace by copy_to_user()/put_user(), or
+	"O: -".
+
+Please, keep the list in alphabetical wrt "N: " order.
 ----------------------------------------------------------------------------
-0x1260
-0x41545900
-0x41545901
-0x4B50
-0x4B51
-ADD_NEW_DISK
-AGPIOC_ACQUIRE
-AGPIOC_ALLOCATE
-AGPIOC_BIND
-AGPIOC_DEALLOCATE
-AGPIOC_INFO
-AGPIOC_PROTECT
-AGPIOC_RELEASE
-AGPIOC_RESERVE
-AGPIOC_SETUP
-AGPIOC_UNBIND
+N: 0x1260 (broken BLKGETSIZE)
+I: -
+O: u32
+
+N: ADD_NEW_DISK
+I: mdu_disk_info_t
+O: -
+
+N: AGPIOC_ACQUIRE
+I: -
+O: -
+
+N: AGPIOC_ALLOCATE
+I: struct agp_allocate
+O: struct agp_allocate
+
+N: AGPIOC_BIND
+I: struct agp_bind
+O: -
+
+N: AGPIOC_DEALLOCATE
+I: (int) arg
+O: -
+
+N: AGPIOC_INFO
+I: -
+O: struct agp_info
+
+N: AGPIOC_PROTECT
+I: -
+O: -
+
+N: AGPIOC_RELEASE
+I: -
+O: -
+
+N: AGPIOC_RESERVE
+I: struct agp_region [+ sizeof(struct agp_segment) * struct agp_region::seg_count]
+O: -
+
+N: AGPIOC_SETUP
+I: struct agp_setup
+O: -
+
+N: AGPIOC_UNBIND
+I: struct agp_unbind
+O: -
+
 AMDTP_IOC_ZAP
-APM_IOC_STANDBY
-APM_IOC_SUSPEND
-ATMARPD_CTRL
-ATMARP_ENCAP
-ATMARP_MKIP
-ATMARP_SETENTRY
-ATMLEC_CTRL
-ATMLEC_DATA
-ATMLEC_MCAST
-ATMMPC_CTRL
-ATMMPC_DATA
-ATMSIGD_CTRL
-ATMTCP_CREATE
-ATMTCP_REMOVE
-ATM_ADDADDR
+
+N: APM_IOC_STANDBY
+I: -
+O: -
+
+N: APM_IOC_SUSPEND
+I: -
+O: -
+
+N: ATMARPD_CTRL
+I: -
+O: -
+
+N: ATMARP_ENCAP
+I: (unsigned char) arg
+O: -
+
+N: ATMARP_MKIP
+I: (int) arg
+O: -
+
+N: ATMARP_SETENTRY
+I: (u32) arg
+O: -
+
+N: ATMLEC_CTRL
+I: (int) arg
+O: -
+
+N: ATMLEC_DATA
+I: struct atmlec_ioc
+O: -
+
+N: ATMLEC_MCAST
+I: (int) arg
+O: -
+
+N: ATMMPC_CTRL
+I: (int) arg
+O: -
+
+N: ATMMPC_DATA
+I: struct atmmpc_ioc
+O: -
+
+N: ATMSIGD_CTRL
+I: -
+O: -
+
+N: ATMTCP_CREATE
+I: (int) arg
+O: -
+
+N: ATMTCP_REMOVE
+I: (int) arg
+O: -
+
+N: ATM_ADDADDR
+I: void __user * + int + int + struct sockaddr_atmsvc
+O: -
+
 ATM_ADDADDR32
-ATM_ADDPARTY
+
+N: ATM_ADDPARTY
+I: struct sockaddr_atmsvc
+O: -
+
 ATM_DELADDR
+I: void __user * + int + int + struct sockaddr_atmsvc
+O: -
+
 ATM_DELADDR32
-ATM_DROPPARTY
-ATM_GETADDR
+
+N: ATM_DROPPARTY
+I: int
+O: -
+
+N: ATM_GETADDR
+I: void __user * + int + int
+O: int
+
 ATM_GETADDR32
-ATM_GETCIRANGE
+
+N: ATM_GETCIRANGE
+I: void __user * + int + int
+O: struct atm_cirange
+
 ATM_GETCIRANGE32
-ATM_GETESI
+
+N: ATM_GETESI
+I: void __user * + int + int
+O: unsigned char [ESI_LEN]
+
 ATM_GETESI32
-ATM_GETLINKRATE
+
+N: ATM_GETLINKRATE
+I: void __user * + int + int
+O: int
+
 ATM_GETLINKRATE32
-ATM_GETLOOP
+
+N: ATM_GETLOOP
+I: -
+O: int
+
 ATM_GETLOOP32
-ATM_GETNAMES
+
+N: ATM_GETNAMES
+I: void __user * + int
+O: int [size]
+
 ATM_GETNAMES32
-ATM_GETSTAT
+
+N: ATM_GETSTAT
+I: void __user * + int + int
+O: struct atm_dev_stats
+
 ATM_GETSTAT32
-ATM_GETSTATZ
+
+N: ATM_GETSTATZ
+I: void __user * + int + int
+O: struct atm_dev_stats
+
 ATM_GETSTATZ32
-ATM_GETTYPE
+
+N: ATM_GETTYPE
+I: void __user * + int + int
+O: char [strlen(struct atm_dev::type) + 1]
+
 ATM_GETTYPE32
-ATM_NEWBACKENDIF
-ATM_QUERYLOOP
+
+N: ATM_NEWBACKENDIF
+I: atm_backend_t + struct atm_newif_br2684
+O: -
+
+N: ATM_QUERYLOOP
+I: -
+O: int
+
 ATM_QUERYLOOP32
-ATM_RSTADDR
+
+N: ATM_RSTADDR
+I: void __user * + int + int
+O: -
+
 ATM_RSTADDR32
-ATM_SETBACKEND
-ATM_SETCIRANGE
+
+N: ATM_SETBACKEND
+I: atm_backend_t + struct atm_backend_br2684
+O: -
+
+N: ATM_SETCIRANGE
+I: void __user * + int + int + struct atm_cirange
+O: -
+
 ATM_SETCIRANGE32
-ATM_SETESI
+
+N: ATM_SETESI
+I: void __user * + int + int + unsigned char [ESI_LEN]
+O: -
+
 ATM_SETESI32
-ATM_SETESIF
+
+N: ATM_SETESIF
+I: void __user * + int + int + unsigned char [ESI_LEN]
+O: -
+
 ATM_SETESIF32
-ATM_SETLOOP
+
+N: ATM_SETLOOP
+I: (int) arg
+O: -
+
 ATM_SETLOOP32
-ATM_SETSC
+
+N: ATM_SETSC
+I: -
+O: -
+
+N: ATYIO_CLKR
+I: -
+O: struct atyclk
+
+N: ATYIO_CLKW
+I: struct atyclk
+O: -
+
+N: ATYIO_FEATR
+I: u32
+O: -
+
+N: ATYIO_FEATW
+I: -
+O: u32
+
 AUDC_CONFIG_PINNACLE
 AUDC_SET_INPUT
 AUDC_SET_RADIO
@@ -106,17 +287,49 @@ AUDIO_SET_MIXER
 AUDIO_SET_MUTE
 AUDIO_SET_STREAMTYPE
 AUDIO_STOP
-AUTOFS_IOC_ASKREGHOST
-AUTOFS_IOC_ASKUMOUNT
-AUTOFS_IOC_CATATONIC
-AUTOFS_IOC_EXPIRE
-AUTOFS_IOC_EXPIRE_MULTI
-AUTOFS_IOC_FAIL
-AUTOFS_IOC_PROTOSUBVER
-AUTOFS_IOC_PROTOVER
-AUTOFS_IOC_READY
+
+N: AUTOFS_IOC_ASKREGHOST
+I: -
+O: int
+
+N: AUTOFS_IOC_ASKUMOUNT
+I: -
+O: int
+
+N: AUTOFS_IOC_CATATONIC
+I: -
+O: -
+
+N: AUTOFS_IOC_EXPIRE
+I: -
+O: struct autofs_packet_expire
+
+N: AUTOFS_IOC_EXPIRE_MULTI
+I: int
+O: -
+
+N: AUTOFS_IOC_FAIL
+I: (autofs_wqt_t) arg
+O: -
+
+N: AUTOFS_IOC_PROTOSUBVER
+I: -
+O: int
+
+N: AUTOFS_IOC_PROTOVER
+I: -
+O: int
+
+N: AUTOFS_IOC_READY
+I: (autofs_wqt_t) arg
+O: -
+
 AUTOFS_IOC_SETTIMEOUT32
-AUTOFS_IOC_TOGGLEREGHOST
+
+N: AUTOFS_IOC_TOGGLEREGHOST
+I: int
+O: -
+
 BIODASDCMFDISABLE
 BIODASDCMFENABLE
 BIODASDDISABLE
@@ -137,44 +350,145 @@ BIODASDRLSE
 BIODASDRSRV
 BIODASDSATTR
 BIODASDSLCK
-BLKBSZGET
+
+N: BLKBSZGET
+I: -
+O: int
+
 BLKBSZGET_32
-BLKBSZSET
+
+N: BLKBSZSET
+I: int
+O: -
+
 BLKBSZSET_32
 BLKELVGET
 BLKELVSET
-BLKFLSBUF
-BLKFRAGET
-BLKFRASET
-BLKGETSIZE
-BLKGETSIZE64
+
+N: BLKFLSBUF
+I: -
+O: -
+
+N: BLKFRAGET
+I: -
+O: long
+
+N: BLKFRASET
+I: (unsigned long) arg
+O: -
+
+N: BLKGETSIZE
+I: -
+O: unsigned long
+
+N: BLKGETSIZE64
+I: -
+O: u64
+
 BLKGETSIZE64_32
-BLKI2OGRSTRAT
-BLKI2OGWSTRAT
-BLKI2OSRSTRAT
-BLKI2OSWSTRAT
-BLKPG
-BLKRAGET
-BLKRASET
-BLKROGET
-BLKROSET
-BLKRRPART
-BLKSECTGET
+
+N: BLKI2OGRSTRAT
+I: -
+O: int
+
+N: BLKI2OGWSTRAT
+I: -
+O: int
+
+N: BLKI2OSRSTRAT
+I: (int) arg
+O: -
+
+N: BLKI2OSWSTRAT
+I: (int) arg
+O: -
+
+N: BLKPG
+I: struct blkpg_ioctl_arg + struct blkpg_partition
+O: -
+
+N: BLKRAGET
+I: -
+O: long
+
+N: BLKRASET
+I: (unsigned long) arg
+O: -
+
+N: BLKROGET
+I: -
+O: int
+
+N: BLKROSET
+I: int
+O: -
+
+N: BLKRRPART
+I: -
+O: -
+
+N: BLKSECTGET
+I: -
+O: unsigned short
+
 BLKSECTSET
-BLKSSZGET
-BNEPCONNADD
-BNEPCONNDEL
-BNEPGETCONNINFO
-BNEPGETCONNLIST
-BPP_GET_DATA
-BPP_GET_PINS
-BPP_PUT_DATA
-BPP_PUT_PINS
-BPP_SET_INPUT
-BR2684_SETFILT
-BT832_HEXDUMP
-BT832_REATTACH
-BTTV_VBISIZE
+
+N: BLKSSZGET
+I: -
+O: int
+
+N: BNEPCONNADD
+I: struct bnep_connadd_req
+O: struct bnep_connadd_req
+
+N: BNEPCONNDEL
+I: struct bnep_conndel_req
+O: -
+
+N: BNEPGETCONNINFO
+I: struct bnep_conninfo
+O: struct bnep_conninfo
+
+N: BNEPGETCONNLIST
+I: struct bnep_connlist_req
+O: struct bnep_connlist_req
+
+N: BPP_GET_DATA
+I: -
+O: -
+
+N: BPP_GET_PINS
+I: -
+O: -
+
+N: BPP_PUT_DATA
+I: (unsigned char) arg
+O: -
+
+N: BPP_PUT_PINS
+I: (unsigned short) arg
+O: -
+
+N: BPP_SET_INPUT
+I: (unsigned long) arg
+O: -
+
+N: BR2684_SETFILT
+I: struct br2684_filter_set
+O: -
+
+N: BT832_HEXDUMP
+I: -
+O: -
+
+N: BT832_REATTACH
+I: -
+O: -
+
+N: BTTV_VBISIZE
+I: -
+O: -
+
 BTTV_VERSION
 BUZIOC_G_PARAMS
 BUZIOC_G_STATUS
@@ -183,130 +497,495 @@ BUZIOC_QBUF_PLAY
 BUZIOC_REQBUFS
 BUZIOC_SYNC
 BUZIOC_S_PARAMS
-CAPI_CLR_FLAGS
-CAPI_GET_ERRCODE
-CAPI_GET_FLAGS
-CAPI_GET_MANUFACTURER
-CAPI_GET_PROFILE
-CAPI_GET_SERIAL
-CAPI_GET_VERSION
-CAPI_INSTALLED
-CAPI_MANUFACTURER_CMD
-CAPI_NCCI_GETUNIT
-CAPI_NCCI_OPENCOUNT
-CAPI_REGISTER
-CAPI_SET_FLAGS
-CA_GET_CAP
-CA_GET_DESCR_INFO
-CA_GET_MSG
-CA_GET_SLOT_INFO
-CA_RESET
-CA_SEND_MSG
-CA_SET_DESCR
-CA_SET_PID
-CCISS_DEREGDISK
-CCISS_REGNEWD
+
+N: CAPI_CLR_FLAGS
+I: unsigned
+O: -
+
+N: CAPI_GET_ERRCODE
+I: -
+O: __u16
+
+N: CAPI_GET_FLAGS
+I: -
+O: unsigned
+
+N: CAPI_GET_MANUFACTURER
+I: __u32
+O: __u8 [CAPI_MANUFACTURER_LEN]
+
+N: CAPI_GET_PROFILE
+I: __u32
+O: __u16
+
+N: CAPI_GET_SERIAL
+I: __u32
+O: __u8 [CAPI_SERIAL_LEN]
+
+N: CAPI_GET_VERSION
+I: __u32
+O: struct capi_version
+
+N: CAPI_INSTALLED
+I: -
+O: -
+
+N: CAPI_MANUFACTURER_CMD
+I: struct capi_manufacturer_cmd
+O: -
+
+N: CAPI_NCCI_GETUNIT
+I: unsigned
+O: -
+
+N: CAPI_NCCI_OPENCOUNT
+I: unsigned
+O: -
+
+N: CAPI_REGISTER
+I: struct capi_register_params
+O: -
+
+N: CAPI_SET_FLAGS
+I: unsigned
+O: -
+
+N: CA_GET_CAP
+I: -
+O: struct ca_caps
+
+N: CA_GET_DESCR_INFO
+I: -
+O: -
+
+N: CA_GET_MSG
+I: struct ca_msg
+O: struct ca_msg | -
+
+N: CA_GET_SLOT_INFO
+I: -
+O: struct ca_slot_info
+
+N: CA_RESET
+I: -
+O: -
+
+N: CA_SEND_MSG
+I: struct ca_msg
+O: -
+
+N: CA_SET_DESCR
+I: -
+O: -
+
+N: CA_SET_PID
+I: -
+O: -
+
+N: CCISS_DEREGDISK
+I: -
+O: -
+
+CCISS_PASSTHRU32
+
+N: CCISS_REGNEWD
+I: -
+O: -
+
 CCISS_RESCANDISK
-CCISS_REVALIDVOLS
-CDROMCLOSETRAY
-CDROMEJECT
-CDROMEJECT_SW
-CDROMMULTISESSION
-CDROMPAUSE
-CDROMPLAYBLK
-CDROMPLAYMSF
-CDROMPLAYTRKIND
-CDROMREADALL
-CDROMREADAUDIO
-CDROMREADCOOKED
-CDROMREADMODE1
-CDROMREADMODE2
-CDROMREADRAW
-CDROMREADTOCENTRY
-CDROMREADTOCHDR
-CDROMRESET
-CDROMRESUME
-CDROMSEEK
-CDROMSTART
-CDROMSTOP
-CDROMSUBCHNL
-CDROMVOLCTRL
-CDROMVOLREAD
-CDROM_CHANGER_NSLOTS
-CDROM_CLEAR_OPTIONS
-CDROM_DEBUG
-CDROM_DISC_STATUS
-CDROM_DRIVE_STATUS
-CDROM_GET_CAPABILITY
-CDROM_GET_MCN
-CDROM_LOCKDOOR
-CDROM_MEDIA_CHANGED
-CDROM_SELECT_DISC
-CDROM_SELECT_SPEED
-CDROM_SEND_PACKET
-CDROM_SET_OPTIONS
-CHIOEXCHANGE
-CHIOGELEM
-CHIOGPARAMS
+
+N: CCISS_REVALIDVOLS
+I: -
+O: -
+
+N: CDROMCLOSETRAY
+I: -
+O: -
+
+N: CDROMEJECT
+I: -
+O: -
+
+N: CDROMEJECT_SW
+I: (unsigned long) arg
+O: -
+
+N: CDROMMULTISESSION
+I: struct cdrom_multisession
+O: struct cdrom_multisession | -
+
+N: CDROMPAUSE
+I: -
+O: -
+
+N: CDROMPLAYBLK
+I: struct cdrom_blk
+O: -
+
+N: CDROMPLAYMSF
+I: struct cdrom_msf
+O: -
+
+N: CDROMPLAYTRKIND
+I: struct cdrom_ti
+O: -
+
+N: CDROMREADALL
+I: struct cdrom_msf
+O: void [CD_FRAMESIZE_RAWER]
+
+N: CDROMREADAUDIO
+I: struct cdrom_read_audio
+O: -
+
+N: CDROMREADCOOKED
+I: struct cdrom_msf
+O: void [CD_FRAMESIZE]
+
+N: CDROMREADMODE1
+I: struct cdrom_msf
+O: unsigned char [CD_FRAMESIZE]
+
+N: CDROMREADMODE2
+I: struct cdrom_msf
+O: unsigned char [CD_FRAMESIZE_RAW0]
+
+N: CDROMREADRAW
+I: struct cdrom_msf
+O: unsigned char [CD_FRAMESIZE_RAW]
+
+N: CDROMREADTOCENTRY
+I: struct cdrom_tocentry
+O: struct cdrom_tocentry
+
+N: CDROMREADTOCHDR
+I: struct cdrom_tocentry
+O: struct cdrom_tocentry
+
+N: CDROMRESET
+I: -
+O: -
+
+N: CDROMRESUME
+I: -
+O: -
+
+N: CDROMSEEK
+I: struct cdrom_msf
+O: -
+
+N: CDROMSTART
+I: -
+O: -
+
+N: CDROMSTOP
+I: -
+O: -
+
+N: CDROMSUBCHNL
+I: struct cdrom_subchnl
+O: struct cdrom_subchnl
+
+N: CDROMVOLCTRL
+I: struct cdrom_volctrl
+O: -
+
+N: CDROMVOLREAD
+I: struct cdrom_volctrl
+O: struct cdrom_volctrl
+
+N: CDROM_CHANGER_NSLOTS
+I: -
+O: -
+
+N: CDROM_CLEAR_OPTIONS
+I: (int) arg
+O: -
+
+N: CDROM_DEBUG
+I: (unsigned long) arg
+O: -
+
+N: CDROM_DISC_STATUS
+I: -
+O: -
+
+N: CDROM_DRIVE_STATUS
+I: (int) arg
+O: -
+
+N: CDROM_GET_CAPABILITY
+I: -
+O: -
+
+N: CDROM_GET_MCN
+I: -
+O: struct cdrom_mcn
+
+N: CDROM_LOCKDOOR
+I: (int) arg
+O: -
+
+N: CDROM_MEDIA_CHANGED
+I: (unsigned int) arg
+O: -
+
+N: CDROM_SELECT_DISC
+I: (int) arg
+O: -
+
+N: CDROM_SELECT_SPEED
+I: (int) arg
+O: -
+
+N: CDROM_SEND_PACKET
+I: struct cdrom_generic_command
+O: struct cdrom_generic_command
+
+N: CDROM_SET_OPTIONS
+I: (int) arg
+O: -
+
+N: CHIOEXCHANGE
+I: struct changer_exchange
+O: -
+
+N: CHIOGELEM
+I: struct changer_get_element
+O: struct changer_get_element
+
+N: CHIOGPARAMS
+I: -
+O: struct changer_params
+
 CHIOGPICKER
-CHIOGSTATUS
-CHIOGSTATUS32
-CHIOGVPARAMS
-CHIOINITELEM
-CHIOMOVE
-CHIOPOSITION
+
+N: CHIOGSTATUS
+I: struct changer_element_status
+O: u_char [?]
+
+N: CHIOGSTATUS32
+I: struct changer_element_status32
+O: u_char [?]
+
+N: CHIOGVPARAMS
+I: -
+O: struct changer_vendor_params
+
+N: CHIOINITELEM
+I: -
+O: -
+
+N: CHIOMOVE
+I: struct changer_move
+O: -
+
+N: CHIOPOSITION
+I: struct changer_position
+O: -
+
 CHIOSPICKER
-CHIOSVOLTAG
-CIFS_IOC_CHECKUMOUNT
-CIOC_KERNEL_VERSION
+
+N: CHIOSVOLTAG
+I: struct changer_set_voltag
+O: -
+
+N: CIFS_IOC_CHECKUMOUNT
+I: -
+O: -
+
+N: CIOC_KERNEL_VERSION
+I: -
+O: int
+
 CLEAR_ARRAY
-CM206CTL_GET_LAST_STAT
-CM206CTL_GET_STAT
-CMD_AC97_BOOST
-CMD_GETCTLGPR
-CMD_GETGPR
-CMD_GETGPR2OSS
-CMD_GETPATCH
-CMD_GETRECSRC
-CMD_GETVOICEPARAM
-CMD_PRIVATE3_VERSION
-CMD_READFN0
-CMD_READPTR
-CMD_SETCTLGPR
-CMD_SETGPOUT
-CMD_SETGPR
-CMD_SETGPR2OSS
-CMD_SETMCH_FX
-CMD_SETPASSTHROUGH
-CMD_SETPATCH
-CMD_SETRECSRC
-CMD_SETVOICEPARAM
-CMD_WRITEFN0
-CMD_WRITEPTR
-CMTPCONNADD
-CMTPCONNDEL
-CMTPGETCONNINFO
-CMTPGETCONNLIST
-COM_CLRPORTSTATS
-COM_GETBRDSTATS
-COM_GETPORTSTATS
-COM_READBOARD
+
+N: CM206CTL_GET_LAST_STAT
+I: (unsigned long) arg
+O: -
+
+N: CM206CTL_GET_STAT
+I: (unsigned long) arg
+O: -
+
+N: CMD_AC97_BOOST
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_GETCTLGPR
+I: struct mixer_private_ioctl
+O: struct mixer_private_ioctl
+
+N: CMD_GETGPR
+I: struct mixer_private_ioctl
+O: struct dsp_gpr
+
+N: CMD_GETGPR2OSS
+I: struct mixer_private_ioctl
+O: struct mixer_private_ioctl
+
+N: CMD_GETPATCH
+I: struct mixer_private_ioctl
+O: struct dsp_rpatch | struct dsp_patch
+
+N: CMD_GETRECSRC
+I: struct mixer_private_ioctl
+O: struct mixer_private_ioctl
+
+N: CMD_GETVOICEPARAM
+I: struct mixer_private_ioctl
+O: struct mixer_private_ioctl
+
+N: CMD_PRIVATE3_VERSION
+I: struct mixer_private_ioctl
+O: struct mixer_private_ioctl
+
+N: CMD_READFN0
+I: struct mixer_private_ioctl
+O: struct mixer_private_ioctl
+
+N: CMD_READPTR
+I: struct mixer_private_ioctl
+O: struct mixer_private_ioctl
+
+N: CMD_SETCTLGPR
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETGPOUT
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETGPR
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETGPR2OSS
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETMCH_FX
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETPASSTHROUGH
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETPATCH
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETRECSRC
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_SETVOICEPARAM
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_WRITEFN0
+I: struct mixer_private_ioctl
+O: -
+
+N: CMD_WRITEPTR
+I: struct mixer_private_ioctl
+O: -
+
+N: CMTPCONNADD
+I: struct cmtp_connadd_req
+O: struct cmtp_connadd_req
+
+N: CMTPCONNDEL
+I: struct cmtp_conndel_req
+O: -
+
+N: CMTPGETCONNINFO
+I: struct cmtp_conninfo
+O: struct cmtp_conninfo
+
+N: CMTPGETCONNLIST
+I: struct cmtp_connlist_req
+O: struct cmtp_connlist_req
+
+N: COM_CLRPORTSTATS
+I: comstats_t
+O: comstats_t
+
+N: COM_GETBRDSTATS
+I: combrd_t
+O: combrd_t
+
+N: COM_GETPORTSTATS
+I: comstats_t
+O: comstats_t
+
+N: COM_READBOARD
+I: stlbrd_t
+O: stlbrd_t
+
 COM_READPANEL
-COM_READPORT
-COSAIOBMGET
-COSAIOBMSET
-COSAIODOWNLD
-COSAIONRCARDS
-COSAIONRCHANS
-COSAIORIDSTR
-COSAIORMEM
-COSAIORSET
-COSAIORTYPE
-COSAIOSTRT
-CPQFC_IOCTL_FC_TDR
-D7SIOCRD
-D7SIOCTM
-D7SIOCWR
+
+N: COM_READPORT
+I: stlport_t
+O: stlport_t
+
+N: COSAIOBMGET
+I: -
+O: -
+
+N: COSAIOBMSET
+I: (unsigned short) arg
+O: -
+
+N: COSAIODOWNLD
+I: struct cosa_download
+O:
+
+N: COSAIONRCARDS
+I: -
+O: -
+
+N: COSAIONRCHANS
+I: -
+O: -
+
+N: COSAIORIDSTR
+I: -
+O: char [COSA_MAX_ID_STRING]
+
+N: COSAIORMEM
+I: struct cosa_download
+O: -
+
+N: COSAIORSET
+I: -
+O: -
+
+N: COSAIORTYPE
+I: -
+O: char [strlen(struct cosa_data::type) + 1]
+
+N: COSAIOSTRT
+I: (int) arg
+O: -
+
+N: CPQFC_IOCTL_FC_TDR
+I: -
+O: -
+
+N: D7SIOCRD
+I: -
+O: int
+
+N: D7SIOCTM
+I: -
+O: -
+
+N: D7SIOCWR
+I: int
+O: -
+
 DASDAPIVER
 DECODER_DUMP
 DECODER_ENABLE_OUTPUT
@@ -325,10 +1004,23 @@ DECODER_SET_NORM
 DECODER_SET_OUTPUT
 DECODER_SET_PICTURE
 DECODER_SET_VBI_BYPASS
-DEVFSDIOC_GET_PROTO_REV
-DEVFSDIOC_RELEASE_EVENT_QUEUE
-DEVFSDIOC_SET_DEBUG_MASK
-DEVFSDIOC_SET_EVENT_MASK
+
+N: DEVFSDIOC_GET_PROTO_REV
+I: -
+O: int
+
+N: DEVFSDIOC_RELEASE_EVENT_QUEUE
+I: -
+O: -
+
+N: DEVFSDIOC_SET_DEBUG_MASK
+I: int
+O: -
+
+N: DEVFSDIOC_SET_EVENT_MASK
+I: (int) arg
+O: -
+
 DMX_GET_CAPS
 DMX_GET_EVENT
 DMX_GET_PES_PIDS
@@ -369,19 +1061,35 @@ DM_TARGET_MSG
 DM_TARGET_MSG_32
 DM_VERSION
 DM_VERSION_32
-DPT_BLINKLED
+
+N: DPT_BLINKLED
+I: -
+O: u32
+
 DPT_CLRSTAT
 DPT_CONFIG
-DPT_CTRLINFO
+
+N: DPT_CTRLINFO
+I: -
+O: drvrHBAinfo_S
+
 DPT_DEBUG
 DPT_NUMCTRLS
 DPT_PERF_INFO
-DPT_SIGNATURE
+
+N: DPT_SIGNATURE
+I: -
+O: static dpt_sig_S
+
 DPT_SIGNATURE_PACKED
 DPT_STATINFO
 DPT_STATS_CLEAR
 DPT_STATS_INFO
-DPT_SYSINFO
+
+N: DPT_SYSINFO
+I: -
+O: struct sysInfo_S
+
 DPT_TARGET_BUSY
 DPT_TIMEOUT
 DRM32_IOCTL_ADD_MAP
@@ -437,13 +1145,35 @@ DS_RESUME_CARD
 DS_SUSPEND_CARD
 DS_UNBIND_REQUEST
 DS_VALIDATE_CIS
-DV1394_IOC_RECEIVE_FRAMES
-DV1394_IOC_SHUTDOWN
-DV1394_IOC_START_RECEIVE
-DV1394_IOC_SUBMIT_FRAMES
-DV1394_IOC_WAIT_FRAMES
-DVD_AUTH
-DVD_READ_STRUCT
+
+N: DV1394_IOC_RECEIVE_FRAMES
+I: (unsigned int) arg
+O: -
+
+N: DV1394_IOC_SHUTDOWN
+I: -
+O: -
+
+N: DV1394_IOC_START_RECEIVE
+I: -
+O: -
+
+N: DV1394_IOC_SUBMIT_FRAMES
+I: (unsigned int) arg
+O: -
+
+N: DV1394_IOC_WAIT_FRAMES
+I: (unsigned int) arg
+O: -
+
+N: DVD_AUTH
+I: dvd_authinfo
+O: dvd_authinfo
+
+N: DVD_READ_STRUCT
+I: dvd_struct
+O: dvd_struct
+
 DVD_WRITE_STRUCT
 EATAUSRCMD
 ENCODER_ENABLE_OUTPUT
@@ -452,7 +1182,11 @@ ENCODER_SET_INPUT
 ENCODER_SET_NORM
 ENCODER_SET_OUTPUT
 ENI_MEMDUMP
-ENI_SETMULT
+
+N: ENI_SETMULT
+I: struct eni_multipliers
+O: -
+
 ENVCTRL_RD_CPU_TEMPERATURE
 ENVCTRL_RD_CPU_VOLTAGE
 ENVCTRL_RD_ETHERNET_TEMPERATURE
@@ -465,18 +1199,42 @@ ENVCTRL_RD_VOLTAGE_STATUS
 ENVCTRL_RD_WARNING_TEMPERATURE
 EVIOCGABS(abs)
 EVIOCGEFFECTS
-EVIOCGID
-EVIOCGKEYCODE
-EVIOCGRAB
-EVIOCGVERSION
-EVIOCRMFF
+
+N: EVIOCGID
+I: -
+O: struct input_id
+
+N: EVIOCGKEYCODE
+I: int
+O: int
+
+N: EVIOCGRAB
+I: (unsigned long) arg
+O: -
+
+N: EVIOCGVERSION
+I: -
+O: int
+
+N: EVIOCRMFF
+I: (int) arg
+O: -
+
 EVIOCSABS(abs)
-EVIOCSKEYCODE
+
+N: EVIOCSKEYCODE
+I: int + int 
+O: -
+
 EXT2_IOC32_GETFLAGS
 EXT2_IOC32_GETVERSION
 EXT2_IOC32_SETFLAGS
 EXT2_IOC32_SETVERSION
-FBIOBLANK
+
+N: FBIOBLANK
+I: (int) arg
+O: -
+
 FBIOGATTR
 FBIOGCURMAX
 FBIOGCURPOS
@@ -485,31 +1243,80 @@ FBIOGCURSOR32
 FBIOGETCMAP
 FBIOGETCMAP32
 FBIOGETCMAP_SPARC
-FBIOGET_CON2FBMAP
-FBIOGET_FSCREENINFO
-FBIOGET_VBLANK
-FBIOGET_VSCREENINFO
-FBIOGTYPE
+
+N: FBIOGET_CON2FBMAP
+I: struct fb_con2fbmap
+O: struct fb_con2fbmap
+
+N: FBIOGET_FSCREENINFO
+I: -
+O: struct fb_fix_screeninfo
+
+N: FBIOGET_VBLANK
+I: -
+O: struct fb_vblank
+
+N: FBIOGET_VSCREENINFO
+I: -
+O: struct fb_var_screeninfo
+
+N: FBIOGTYPE
+I: -
+O: struct fbtype
+
 FBIOGVIDEO
-FBIOPAN_DISPLAY
+
+N: FBIOPAN_DISPLAY
+I: struct fb_var_screeninfo
+O: -
+
 FBIOPUTCMAP
 FBIOPUTCMAP32
 FBIOPUTCMAP_SPARC
 FBIOPUT_CON2FBMAP
-FBIOPUT_VSCREENINFO
+
+N: FBIOPUT_VSCREENINFO
+I: struct fb_var_screeninfo
+O: struct fb_var_screeninfo
+
 FBIOSATTR
 FBIOSCURPOS
 FBIOSCURSOR
 FBIOSCURSOR32
 FBIOSVIDEO
-FBIO_ATY128_GET_MIRROR
-FBIO_ATY128_SET_MIRROR
-FBIO_CURSOR
-FBIO_GETCONTROL2
-FBIO_RADEON_GET_MIRROR
-FBIO_RADEON_SET_MIRROR
-FBIO_WAITEVENT
-FBIO_WAITFORVSYNC
+
+N: FBIO_ATY128_GET_MIRROR
+I: -
+O: __u32
+
+N: FBIO_ATY128_SET_MIRROR
+I: __u32
+O: -
+
+N: FBIO_CURSOR
+I: -
+O: -
+
+N: FBIO_GETCONTROL2
+I: -
+O: unsigned char
+
+N: FBIO_RADEON_GET_MIRROR
+I: -
+O: __u32
+
+N: FBIO_RADEON_SET_MIRROR
+I: __u32
+O: -
+
+N: FBIO_WAITEVENT
+I: -
+O: -
+
+N: FBIO_WAITFORVSYNC
+I: __u32
+O: -
+
 FBIO_WID_ALLOC
 FBIO_WID_FREE
 FBIO_WID_GET
@@ -565,31 +1372,99 @@ FE_READ_UNCORRECTED_BLOCKS
 FE_SET_FRONTEND
 FE_SET_TONE
 FE_SET_VOLTAGE
-FIBMAP
-FIGETBSZ
-FIOASYNC
-FIOCLEX
-FIOGETOWN
-FIONBIO
-FIONCLEX
-FIONREAD
-FIOQSIZE
-FIOSETOWN
-FSACTL_CLOSE_GET_ADAPTER_FIB
-FSACTL_DELETE_DISK
-FSACTL_FORCE_DELETE_DISK
-FSACTL_GET_CONTAINERS
-FSACTL_GET_NEXT_ADAPTER_FIB
-FSACTL_GET_PCI_INFO
-FSACTL_MINIPORT_REV_CHECK
-FSACTL_OPEN_GET_ADAPTER_FIB
-FSACTL_QUERY_DISK
+
+N: FIBMAP
+I: int
+O: int
+
+N: FIGETBSZ
+I: -
+O: int
+
+N: FIOASYNC
+I: int
+O: -
+
+N: FIOCLEX
+I: -
+O: -
+
+N: FIOGETOWN
+I: -
+O: int
+
+N: FIONBIO
+I: int
+O: -
+
+N: FIONCLEX
+I: -
+O: -
+
+N: FIONREAD
+I: -
+O: int
+
+N: FIOQSIZE
+I: -
+O: loff_t
+
+N: FIOSETOWN
+I: int
+O: -
+
+N: FSACTL_CLOSE_GET_ADAPTER_FIB
+I: (u32) arg
+O: -
+
+N: FSACTL_DELETE_DISK
+I: struct aac_delete_disk
+O: -
+
+N: FSACTL_FORCE_DELETE_DISK
+I: struct aac_delete_disk
+O: -
+
+N: FSACTL_GET_CONTAINERS
+I: -
+O: -
+
+N: FSACTL_GET_NEXT_ADAPTER_FIB
+I: struct fib_ioctl
+O: [struct hw_fib]
+
+N: FSACTL_GET_PCI_INFO
+I: -
+O: struct aac_pci_info
+
+N: FSACTL_MINIPORT_REV_CHECK
+I: -
+O: struct revision
+
+N: FSACTL_OPEN_GET_ADAPTER_FIB
+I: -
+O: u32
+
+N: FSACTL_QUERY_DISK
+I: struct aac_query_disk
+O: struct aac_query_disk
+
 FSACTL_SENDFIB
 FSACTL_SEND_LARGE_FIB
 FSACTL_SEND_RAW_SRB
-GADGETFS_CLEAR_HALT
-GADGETFS_FIFO_FLUSH
-GADGETFS_FIFO_STATUS
+
+N: GADGETFS_CLEAR_HALT
+I: -
+O: -
+
+N: GADGETFS_FIFO_FLUSH
+I: -
+O: -
+
+N: GADGETFS_FIFO_STATUS
+I: -
+O: -
+
 GCAOFF
 GCAON
 GCDESCRIBE
@@ -616,13 +1491,35 @@ GIO_FONTX
 GIO_SCRNMAP
 GIO_UNIMAP
 GIO_UNISCRNMAP
-HCIDEVDOWN
-HCIDEVRESET
-HCIDEVRESTAT
-HCIDEVUP
-HCIGETCONNINFO
-HCIGETCONNLIST
-HCIGETDEVINFO
+
+N: HCIDEVDOWN
+I: (__u16) arg
+O: -
+
+N: HCIDEVRESET
+I: (__u16) arg
+O: -
+
+N: HCIDEVRESTAT
+I: (__u16) arg
+O: -
+
+N: HCIDEVUP
+I: (__u16) arg
+O: -
+
+N: HCIGETCONNINFO
+I: struct hci_conn_info_req
+O: struct hci_conn_info
+
+N: HCIGETCONNLIST
+I: struct hci_conn_list_req
+O: struct hci_conn_info
+
+N: HCIGETDEVINFO
+I: struct hci_dev_info
+O: struct hci_dev_info
+
 HCIGETDEVLIST
 HCIINQUIRY
 HCISETACLMTU
@@ -657,7 +1554,11 @@ HDIO_SET_NICE
 HDIO_SET_NOWERR
 HDIO_SET_PIO_MODE
 HDIO_SET_UNMASKINTR
-HE_GET_REG
+
+N: HE_GET_REG
+I: struct he_ioctl_reg
+O: struct he_ioctl_reg
+
 HIDIOCAPPLICATION
 HIDIOCGCOLLECTIONINDEX
 HIDIOCGCOLLECTIONINFO
@@ -698,9 +1599,19 @@ I2C_SLAVE_FORCE
 I2C_SMBUS
 I2C_TENBIT
 I2C_TIMEOUT
-I2OEVTGET
-I2OEVTREG
-I2OGETIOPS
+
+N: I2OEVTGET
+I: -
+O: struct i2o_evt_get
+
+N: I2OEVTREG
+I: struct i2o_evt_id
+O: -
+
+N: I2OGETIOPS
+I: -
+O: u8 [MAX_I2O_CONTROLLERS];
+
 I2OHRTGET
 I2OHTML
 I2OLCTGET
@@ -723,8 +1634,15 @@ I8K_GET_TEMP
 I8K_MACHINE_ID
 I8K_POWER_STATUS
 I8K_SET_FAN
-IDT77105_GETSTAT
-IDT77105_GETSTATZ
+
+N: IDT77105_GETSTAT
+I: -
+O: struct idt77105_stats
+
+N: IDT77105_GETSTATZ
+I: -
+O: struct idt77105_stats
+
 IIOCDBGVAR
 IIOCDELRULE
 IIOCDOCFACT
@@ -798,7 +1716,15 @@ IOCTL_TIUSB_RESET_PIPES
 IOCTL_TIUSB_TIMEOUT
 IOC_NVRAM_GET_OFFSET
 IOC_NVRAM_SYNC
-IRTTY_IOCTDONGLE
+
+N: IRTTY_IOCGET
+I: -
+O: struct irtty_info
+
+N: IRTTY_IOCTDONGLE
+I: (IRDA_DONGLE) arg
+O: -
+
 IXJCTL_AEC_GET_LEVEL
 IXJCTL_AEC_START
 IXJCTL_AEC_STOP
@@ -841,9 +1767,19 @@ IXJCTL_TONE_CADENCE
 IXJCTL_VERSION
 IXJCTL_VMWI
 IXJCTL_WRITE_WAIT
-JFFS_GET_STATUS
-JFFS_PRINT_HASH
-JFFS_PRINT_TREE
+
+N: JFFS_GET_STATUS
+I: -
+O: struct jffs_flash_status
+
+N: JFFS_PRINT_HASH
+I: -
+O: -
+
+N: JFFS_PRINT_TREE
+I: -
+O: -
+
 JSIOCGAXES
 JSIOCGAXMAP
 JSIOCGBTNMAP
@@ -857,6 +1793,7 @@ KDFONTOP
 KDGETKEYCODE
 KDGETLED
 KDGETMODE
+KDGHWCLK
 KDGKBDIACR
 KDGKBENT
 KDGKBLED
@@ -869,6 +1806,7 @@ KDMKTONE
 KDSETKEYCODE
 KDSETLED
 KDSETMODE
+KDSHWCLK
 KDSIGACCEPT
 KDSKBDIACR
 KDSKBENT
@@ -899,20 +1837,63 @@ LEO_CLUTPOST
 LEO_CLUTREAD
 LEO_GETGAMMA
 LEO_SETGAMMA
-LOOP_CHANGE_FD
-LOOP_CLR_FD
-LOOP_GET_STATUS
-LOOP_GET_STATUS64
-LOOP_SET_FD
-LOOP_SET_STATUS
-LOOP_SET_STATUS64
-LPGETSTATUS
-MATROXFB_GET_ALL_OUTPUTS
-MATROXFB_GET_AVAILABLE_OUTPUTS
-MATROXFB_GET_OUTPUT_CONNECTION
-MATROXFB_GET_OUTPUT_MODE
-MATROXFB_SET_OUTPUT_CONNECTION
-MATROXFB_SET_OUTPUT_MODE
+
+N: LOOP_CHANGE_FD
+I: (unsigned int) arg
+O: -
+
+N: LOOP_CLR_FD
+I: -
+O: -
+
+N: LOOP_GET_STATUS
+I: -
+O: struct loop_info
+
+N: LOOP_GET_STATUS64
+I: -
+O: struct loop_info64
+
+N: LOOP_SET_FD
+I: (unsigned int) arg
+O: -
+
+N: LOOP_SET_STATUS
+I: struct loop_info
+O: -
+
+N: LOOP_SET_STATUS64
+I: struct loop_info64
+O: -
+
+N: LPGETSTATUS
+I: -
+O: int
+
+N: MATROXFB_GET_ALL_OUTPUTS
+I: -
+O: u_int32_t
+
+N: MATROXFB_GET_AVAILABLE_OUTPUTS
+I: -
+O: u_int32_t
+
+N: MATROXFB_GET_OUTPUT_CONNECTION
+I: -
+O: u_int32_t
+
+N: MATROXFB_GET_OUTPUT_MODE
+I: struct matroxioc_output_mode
+O: struct matroxioc_output_mode
+
+N: MATROXFB_SET_OUTPUT_CONNECTION
+I: u_int32_t
+O: -
+
+N: MATROXFB_SET_OUTPUT_MODE
+I: struct matroxioc_output_mode
+O: -
+
 MCE_GETCLEAR_FLAGS
 MCE_GET_LOG_LEN
 MCE_GET_RECORD_LEN
@@ -1028,8 +2009,15 @@ NET_REMOVE_IF
 NS_ADJBUFLEV
 NS_GETPSTAT
 NS_SETBUFLEV
-NVRAM_INIT
-NVRAM_SETCKS
+
+N: NVRAM_INIT
+I: -
+O: -
+
+N: NVRAM_SETCKS
+I: -
+O: -
+
 OLD_PHONE_RING_START
 OPIOCGET
 OPIOCGETCHILD
@@ -1137,41 +2125,147 @@ PLANBIOCSSAAREGS
 PLANB_INTR_DEBUG
 PLANB_INV_REGS
 PMU_IOC_SLEEP
-PPCLAIM
-PPCLRIRQ
-PPDATADIR
-PPEXCL
-PPFCONTROL
-PPGETFLAGS
-PPGETMODE
-PPGETMODES
-PPGETPHASE
-PPNEGOT
-PPPIOCATTACH
-PPPIOCATTCHAN
-PPPIOCBUNDLE
-PPPIOCCONNECT
-PPPIOCDETACH
-PPPIOCDISCONN
-PPPIOCGASYNCMAP
-PPPIOCGCALLINFO
-PPPIOCGCHAN
-PPPIOCGCOMPRESSORS
-PPPIOCGDEBUG
-PPPIOCGFLAGS
-PPPIOCGIDLE
+
+N: PPCLAIM
+I: -
+O: -
+
+N: PPCLRIRQ
+I: -
+O: int
+
+N: PPDATADIR
+I: int
+O: -
+
+N: PPEXCL
+I: -
+O: -
+
+N: PPFCONTROL
+I: unsigned char + unsigned char
+O: -
+
+N: PPGETFLAGS
+I: -
+O: int
+
+N: PPGETMODE
+I: -
+O: int
+
+N: PPGETMODES
+I: -
+O: unsigned int
+
+N: PPGETPHASE
+I: -
+O: int
+
+N: PPGETTIME
+I: -
+O: struct timeval
+
+N: PPNEGOT
+I: int
+O: -
+
+N: PPPIOCATTACH
+I: int
+O: -
+
+N: PPPIOCATTCHAN
+I: int
+O: -
+
+N: PPPIOCBUNDLE
+I: unsigned long
+O: -
+
+N: PPPIOCCONNECT
+I: int
+O: -
+
+N: PPPIOCDETACH
+I: -
+O: -
+
+N: PPPIOCDISCONN
+I: -
+O: -
+
+N: PPPIOCGASYNCMAP
+I: -
+O: __u32
+
+N: PPPIOCGCALLINFO
+I: -
+O: struct pppcallinfo
+
+N: PPPIOCGCHAN
+I: -
+O: int
+
+N: PPPIOCGCOMPRESSORS
+I: -
+O: unsigned long [8]
+
+N: PPPIOCGDEBUG
+I: -
+O: unsigned long
+
+N: PPPIOCGFLAGS
+I: -
+O: unsigned int
+
+N: PPPIOCGIDLE
+I: -
+O: struct ppp_idle
+
 PPPIOCGIDLE32
-PPPIOCGIFNAME
-PPPIOCGMPFLAGS
-PPPIOCGMRU
-PPPIOCGNPMODE
-PPPIOCGRASYNCMAP
-PPPIOCGUNIT
-PPPIOCGXASYNCMAP
-PPPIOCNEWUNIT
-PPPIOCSACTIVE
+
+N: PPPIOCGIFNAME
+I: -
+O: char [10]
+
+N: PPPIOCGMPFLAGS
+I: -
+O: unsigned int
+
+N: PPPIOCGMRU
+I: -
+O: int
+
+N: PPPIOCGNPMODE
+I: struct npioctl
+O: struct npioctl
+
+N: PPPIOCGRASYNCMAP
+I: -
+O: u32
+
+N: PPPIOCGUNIT
+I: -
+O: int
+
+N: PPPIOCGXASYNCMAP
+I: -
+O: u32 [8]
+
+N: PPPIOCNEWUNIT
+I: int
+O: int
+
+N: PPPIOCSACTIVE
+I: struct sock_fprog + struct sock_fprog::len * struct sock_filter
+O: -
+
 PPPIOCSACTIVE32
-PPPIOCSASYNCMAP
+
+N: PPPIOCSASYNCMAP
+I: u32
+O: -
+
 PPPIOCSCOMPRESS
 PPPIOCSCOMPRESS32
 PPPIOCSCOMPRESSOR
@@ -1183,30 +2277,99 @@ PPPIOCSMPMRU
 PPPIOCSMPMTU
 PPPIOCSMRRU
 PPPIOCSMRU
-PPPIOCSNPMODE
-PPPIOCSPASS
+
+N: PPPIOCSNPMODE
+I: struct npioctl
+O: -
+
+N: PPPIOCSPASS
+I: struct sock_fprog + struct sock_fprog::len * struct sock_filter
+O:
+
 PPPIOCSPASS32
-PPPIOCSRASYNCMAP
-PPPIOCSXASYNCMAP
+
+N: PPPIOCSRASYNCMAP
+I: u32
+O: -
+
+N: PPPIOCSXASYNCMAP
+I: u32 [8]
+O: -
+
 PPPIOCXFERUNIT
-PPPOEIOCDFWD
+
+N: PPPOEIOCDFWD
+I: -
+O: -
+
 PPPOEIOCGFWD
-PPPOEIOCSFWD
-PPRCONTROL
-PPRDATA
-PPRELEASE
-PPRSTATUS
-PPSETFLAGS
-PPSETMODE
-PPSETPHASE
-PPWCONTROL
-PPWCTLONIRQ
-PPWDATA
-PPYIELD
-PRINT_RAID_DEBUG
+
+N: PPPOEIOCSFWD
+I: struct sockaddr_pppox
+O: -
+
+N: PPRCONTROL
+I: -
+O: unsigned char
+
+N: PPRDATA
+I: -
+O: unsigned char
+
+N: PPRELEASE
+I: -
+O: -
+
+N: PPRSTATUS
+I: -
+O: unsigned char
+
+N: PPSETFLAGS
+I: int
+O: -
+
+N: PPSETMODE
+I: int
+O: -
+
+N: PPSETPHASE
+I: int
+O: -
+
+N: PPSETTIME
+I: struct timeval
+O: -
+
+N: PPWCONTROL
+I: unsigned char
+O: -
+
+N: PPWCTLONIRQ
+I: unsigned char
+O: -
+
+N: PPWDATA
+I: unsigned char
+O: -
+
+N: PPYIELD
+I: -
+O: -
+
+N: PRINT_RAID_DEBUG
+I: -
+O: -
+
 PROTECT_ARRAY
-RAID_AUTORUN
-RAID_VERSION
+
+N: RAID_AUTORUN
+I: (int) arg
+O: -
+
+N: RAID_VERSION
+I: -
+O: struct mdu_version_s
+
 RAW_GETBIND
 RAW_SETBIND
 REISERFS_IOC_UNPACK32
@@ -1228,45 +2391,153 @@ RTC32_IRQP_READ
 RTC32_IRQP_SET
 RTCGET
 RTCSET
-RTC_AIE_OFF
-RTC_AIE_ON
-RTC_ALM_READ
-RTC_ALM_SET
-RTC_EPOCH_READ
+
+N: RTC_AIE_OFF
+I: -
+O: -
+
+N: RTC_AIE_ON
+I: -
+O: -
+
+N: RTC_ALM_READ
+I: -
+O: struct rtc_time
+
+N: RTC_ALM_SET
+I: struct rtc_time
+O: -
+
+N: RTC_EPOCH_READ
+I: -
+O: unsigned long
+
 RTC_EPOCH_READ32
-RTC_EPOCH_SET
+
+N: RTC_EPOCH_SET
+I: (unsigned long) arg
+O: -
+
 RTC_EPOCH_SET32
-RTC_IRQP_READ
+
+N: RTC_IRQP_READ
+I: -
+O: unsigned long
+
 RTC_IRQP_READ32
-RTC_IRQP_SET
+
+N: RTC_IRQP_SET
+I: (unsigned long) arg
+O: -
+
 RTC_IRQP_SET32
-RTC_PIE_OFF
-RTC_PIE_ON
-RTC_PLL_GET
-RTC_PLL_SET
-RTC_RD_TIME
-RTC_SET_CHARGE
-RTC_SET_TIME
-RTC_UIE_OFF
-RTC_UIE_ON
-RTC_VLOW_RD
-RTC_VLOW_SET
-RTC_WIE_OFF
-RTC_WIE_ON
-RTC_WKALM_RD
-RTC_WKALM_SET
-RUN_ARRAY
-SBPROF_ZBSTART
-SBPROF_ZBSTOP
-SBPROF_ZBWAITFULL
-SCSI_IOCTL_DOORLOCK
-SCSI_IOCTL_DOORUNLOCK
-SCSI_IOCTL_GET_BUS_NUMBER
-SCSI_IOCTL_GET_IDLUN
-SCSI_IOCTL_GET_PCI
-SCSI_IOCTL_PROBE_HOST
+
+N: RTC_PIE_OFF
+I: -
+O: -
+
+N: RTC_PIE_ON
+I: -
+O: -
+
+N: RTC_PLL_GET
+I: -
+O: struct rtc_pll_info
+
+N: RTC_PLL_SET
+I: struct rtc_pll_info
+O: -
+
+N: RTC_RD_TIME
+I: -
+O: struct rtc_time
+
+N: RTC_SET_CHARGE
+I: int
+O: -
+
+N: RTC_SET_TIME
+I: struct rtc_time
+O: -
+
+N: RTC_UIE_OFF
+I: -
+O: -
+
+N: RTC_UIE_ON
+I: -
+O: -
+
+N: RTC_VLOW_RD
+I: -
+O: int
+
+N: RTC_VLOW_SET
+I: -
+O: -
+
+N: RTC_WIE_OFF
+I: -
+O: -
+
+N: RTC_WIE_ON
+I: -
+O: -
+
+N: RTC_WKALM_RD
+I: -
+O: unsigned char + unsigned char + struct rtc_time
+
+N: RTC_WKALM_SET
+I: unsigned char + struct rtc_time
+O: -
+
+N: RUN_ARRAY
+I: -
+O: -
+
+N: SBPROF_ZBSTART
+I: -
+O: -
+
+N: SBPROF_ZBSTOP
+I: -
+O: -
+
+N: SBPROF_ZBWAITFULL
+I: -
+O: int
+
+N: SCSI_IOCTL_DOORLOCK
+I: -
+O: -
+
+N: SCSI_IOCTL_DOORUNLOCK
+I: -
+O: -
+
+N: SCSI_IOCTL_GET_BUS_NUMBER
+I: -
+O: int
+
+N: SCSI_IOCTL_GET_IDLUN
+I: -
+O: struct scsi_idlun
+
+N: SCSI_IOCTL_GET_PCI
+I: -
+O: char [BUS_ID_SIZE]
+
+N: SCSI_IOCTL_PROBE_HOST
+I: unsigned int
+O: char [?]
+
 SCSI_IOCTL_SEND_COMMAND
-SCSI_IOCTL_TEST_UNIT_READY
+
+N: SCSI_IOCTL_TEST_UNIT_READY
+I: -
+O: -
+
 SET_ARRAY_INFO
 SET_BITMAP_FILE
 SET_DISK_FAULTY
@@ -1549,7 +2820,11 @@ STOP_ARRAY_RO
 TAPE390_DISPLAY
 TCFLSH
 TCGETA
-TCGETS
+
+N: TCGETS
+I: -
+O: struct termios
+
 TCSBRK
 TCSBRKP
 TCSETA
@@ -1571,11 +2846,23 @@ TIOCCBRK
 TIOCCONS
 TIOCEXCL
 TIOCGDEV
-TIOCGETC
+
+N: TIOCGETC
+I: -
+O: struct tchars
+
 TIOCGETD
-TIOCGETP
+
+N: TIOCGETP
+I: -
+O: struct sgttyb
+
 TIOCGICOUNT
-TIOCGLTC
+
+N: TIOCGLTC
+I: -
+O: struct ltchars
+
 TIOCGPGRP
 TIOCGPTN
 TIOCGSERIAL
@@ -1605,11 +2892,25 @@ TIOCSERSWILD
 TIOCSETA
 TIOCSETAF
 TIOCSETAW
-TIOCSETC
+
+N: TIOCSETC
+I: struct tchars
+O: -
+
 TIOCSETD
-TIOCSETN
-TIOCSETP
-TIOCSLTC
+
+N: TIOCSETN
+I: struct sgttyb
+O: -
+
+N: TIOCSETP
+I: struct sgttyb
+O: -
+
+N: TIOCSLTC
+I: struct ltchars
+O: -
+
 TIOCSPGRP
 TIOCSPTLCK
 TIOCSSERIAL
@@ -1639,8 +2940,55 @@ UDF_GETEABLOCK
 UDF_GETEASIZE
 UDF_GETVOLIDENT
 UDF_RELOCATE_BLOCKS
-UI_DEV_CREATE
-UI_DEV_DESTROY
+
+UI_BEGIN_FF_ERASE
+UI_BEGIN_FF_UPLOAD
+
+N: UI_DEV_CREATE
+I: -
+O: -
+
+N: UI_DEV_DESTROY
+I: -
+O: -
+
+UI_END_FF_ERASE
+UI_END_FF_UPLOAD
+
+N: UI_SET_ABSBIT
+I: (int) arg
+O: -
+
+N: UI_SET_EVBIT
+I: (int) arg
+O: -
+
+N: UI_SET_FFBIT
+I: (int) arg
+O: -
+
+N: UI_SET_KEYBIT
+I: (int) arg
+O: -
+
+N: UI_SET_LEDBIT
+I: (int) arg
+O: -
+
+N: UI_SET_MSCBIT
+I: (int) arg
+O: -
+
+UI_SET_PHYS
+
+N: UI_SET_RELBIT
+I: (int) arg
+O: -
+
+N: UI_SET_SNDBIT
+I: (int) arg
+O: -
+
 UNPROTECT_ARRAY
 USBDEVFS_BULK
 USBDEVFS_BULK32
@@ -1764,55 +3112,135 @@ VIDIOCSWIN
 VIDIOCSWIN32
 VIDIOCSWRITEMODE
 VIDIOCSYNC
-VIDIOC_CROPCAP
+
+N: VIDIOC_CROPCAP
+I: -
+O: struct v4l2_cropcap
+
 VIDIOC_CROPCAP_OLD
-VIDIOC_DQBUF
+
+N: VIDIOC_DQBUF
+I: struct v4l2_buffer
+O: struct v4l2_buffer
+
 VIDIOC_ENUMAUDIO
 VIDIOC_ENUMAUDOUT
-VIDIOC_ENUMINPUT
+
+N: VIDIOC_ENUMINPUT
+I: struct v4l2_input
+O: struct v4l2_input
+
 VIDIOC_ENUMOUTPUT
 VIDIOC_ENUMSTD
-VIDIOC_ENUM_FMT
+
+N: VIDIOC_ENUM_FMT
+I: struct v4l2_fmtdesc
+O: struct v4l2_fmtdesc
+
 VIDIOC_G_AUDIO
 VIDIOC_G_AUDIO_OLD
 VIDIOC_G_AUDOUT
 VIDIOC_G_AUDOUT_OLD
 VIDIOC_G_CROP
-VIDIOC_G_CTRL
+
+N: VIDIOC_G_CTRL
+I: struct v4l2_control
+O: struct v4l2_control
+
 VIDIOC_G_FBUF
-VIDIOC_G_FMT
+
+N: VIDIOC_G_FMT
+I: struct v4l2_format
+O: struct v4l2_format
+
 VIDIOC_G_FREQUENCY
-VIDIOC_G_INPUT
-VIDIOC_G_JPEGCOMP
+
+N: VIDIOC_G_INPUT
+I: int
+O: -
+
+N: VIDIOC_G_JPEGCOMP
+I: -
+O: struct v4l2_jpegcompression
+
 VIDIOC_G_MODULATOR
 VIDIOC_G_MPEGCOMP
 VIDIOC_G_OUTPUT
-VIDIOC_G_PARM
+
+N: VIDIOC_G_PARM
+I: struct v4l2_streamparm
+O: struct v4l2_streamparm
+
 VIDIOC_G_PRIORITY
 VIDIOC_G_STD
 VIDIOC_G_TUNER
 VIDIOC_OVERLAY
 VIDIOC_OVERLAY_OLD
-VIDIOC_QBUF
-VIDIOC_QUERYBUF
-VIDIOC_QUERYCAP
-VIDIOC_QUERYCTRL
+
+N: VIDIOC_QBUF
+I: struct v4l2_buffer
+O: -
+
+N: VIDIOC_QUERYBUF
+I: struct v4l2_buffer
+O: struct v4l2_buffer
+
+N: VIDIOC_QUERYCAP
+I: -
+O: struct v4l2_capability
+
+N: VIDIOC_QUERYCTRL
+I: struct v4l2_queryctrl
+O: struct v4l2_queryctrl
+
 VIDIOC_QUERYMENU
 VIDIOC_QUERYSTD
-VIDIOC_REQBUFS
+
+N: VIDIOC_REQBUFS
+I: struct v4l2_requestbuffers
+O: struct v4l2_requestbuffers
+
 VIDIOC_RESERVED
-VIDIOC_STREAMOFF
-VIDIOC_STREAMON
+
+N: VIDIOC_STREAMOFF
+I: int
+O: -
+
+N: VIDIOC_STREAMON
+I: int
+O: -
+
 VIDIOC_S_AUDIO
 VIDIOC_S_AUDOUT
-VIDIOC_S_CROP
-VIDIOC_S_CTRL
-VIDIOC_S_CTRL_OLD
+
+N: VIDIOC_S_CROP
+I: struct v4l2_crop
+O: struct v4l2_crop
+
+N: VIDIOC_S_CTRL
+I: struct v4l2_control
+O: -
+
+N: VIDIOC_S_CTRL_OLD
+I: struct v4l2_control
+O: -
+
 VIDIOC_S_FBUF
-VIDIOC_S_FMT
+
+N: VIDIOC_S_FMT
+I: struct v4l2_format
+O: struct v4l2_format
+
 VIDIOC_S_FREQUENCY
-VIDIOC_S_INPUT
-VIDIOC_S_JPEGCOMP
+
+N: VIDIOC_S_INPUT
+I: int
+O: -
+
+N: VIDIOC_S_JPEGCOMP
+I: struct v4l2_jpegcompression
+O: -
+
 VIDIOC_S_MODULATOR
 VIDIOC_S_MPEGCOMP
 VIDIOC_S_OUTPUT
@@ -1821,10 +3249,23 @@ VIDIOC_S_PARM_OLD
 VIDIOC_S_PRIORITY
 VIDIOC_S_STD
 VIDIOC_S_TUNER
-VIDIOC_TRY_FMT
-VMCP_GETCODE
-VMCP_GETSIZE
-VMCP_SETBUF
+
+N: VIDIOC_TRY_FMT
+I: struct v4l2_format
+O: struct v4l2_format
+
+N: VMCP_GETCODE
+I: -
+O: int
+
+N: VMCP_GETSIZE
+I: -
+O: int
+
+N: VMCP_SETBUF
+I: int
+O: -
+
 VTXIOCCLRCACHE
 VTXIOCCLRFOUND
 VTXIOCCLRPAGE
@@ -1837,36 +3278,120 @@ VTXIOCPUTSTAT
 VTXIOCSETDISP
 VTXIOCSETVIRT
 VTXIOCSTOPDAU
-VT_ACTIVATE
-VT_DISALLOCATE
-VT_GETMODE
-VT_GETSTATE
-VT_LOCKSWITCH
-VT_OPENQRY
-VT_RELDISP
-VT_RESIZE
-VT_RESIZEX
-VT_SETMODE
-VT_UNLOCKSWITCH
-VT_WAITACTIVE
+
+N: VT_ACTIVATE
+I: (unsigned int) arg
+O: -
+
+N: VT_DISALLOCATE
+I: (unsigned int) arg
+O: -
+
+N: VT_GETMODE
+I: -
+O: struct vt_mode
+
+N: VT_GETSTATE
+I: -
+O: unsigned short + unsigned short
+
+N: VT_LOCKSWITCH
+I: -
+O: -
+
+N: VT_OPENQRY
+I: -
+O: int
+
+N: VT_RELDISP
+I: (unsigned long) arg
+O: -
+
+N: VT_RESIZE
+I: ushort + ushort
+O: -
+
+N: VT_RESIZEX
+I: ushort + ushort + ushort + ushort + ushort + ushort
+O: -
+
+N: VT_SETMODE
+I: struct vt_mode
+O: -
+
+N: VT_UNLOCKSWITCH
+I: -
+O: -
+
+N: VT_WAITACTIVE
+I: (int) arg
+O: -
+
 VUIDGFORMAT
 VUIDSFORMAT
-WDIOC_GETBOOTSTATUS
-WDIOC_GETSTATUS
-WDIOC_GETSUPPORT
-WDIOC_GETTEMP
-WDIOC_GETTIMEOUT
-WDIOC_KEEPALIVE
-WDIOC_SETOPTIONS
-WDIOC_SETTIMEOUT
-WIOCGSTAT
-WIOCSTART
-WIOCSTOP
+
+N: WDIOC_GETBOOTSTATUS
+I: -
+O: int
+
+N: WDIOC_GETSTATUS
+I: -
+O: int
+
+N: WDIOC_GETSUPPORT
+I: -
+O: struct watchdog_info
+
+N: WDIOC_GETTEMP
+I: -
+O: int
+
+N: WDIOC_GETTIMEOUT
+I: -
+O: int
+
+N: WDIOC_KEEPALIVE
+I: -
+O: -
+
+N: WDIOC_SETOPTIONS
+I: int
+O: -
+
+N: WDIOC_SETTIMEOUT
+I: int
+O: int
+
+N: WIOCGSTAT
+I: -
+O: int
+
+N: WIOCSTART
+I: -
+O: -
+
+N: WIOCSTOP
+I: -
+O: -
+
 WRITE_RAID_INFO
-Z90QUIESCE
-ZATM_GETPOOL
-ZATM_GETPOOLZ
-ZATM_SETPOOL
+
+N: Z90QUIESCE
+I: -
+O: -
+
+N: ZATM_GETPOOL
+I: int
+O: struct zatm_pool_info
+
+N: ZATM_GETPOOLZ
+I: int
+O: struct zatm_pool_info
+
+N: ZATM_SETPOOL
+I: int + struct zatm_pool_info
+O: -
+
 __NET_ADD_IF_OLD
 __NET_GET_IF_OLD
 __TCGETSTAT

