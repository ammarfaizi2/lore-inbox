Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUI1UqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUI1UqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUI1UqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:46:06 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:60559 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267881AbUI1Ukv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:40:51 -0400
Date: Tue, 28 Sep 2004 21:40:48 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Re: [2.6-BK-URL] NTFS: Final sparse annotation/fixes.
In-Reply-To: <Pine.LNX.4.60.0409282138570.4614@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409282139220.4614@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409282133290.4614@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409282137410.4614@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409282138350.4614@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409282138570.4614@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4/4 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/28 1.1994.1.2)
   NTFS: Change all the defines back to simple enums since sparse is now happy
         typed enums.  This completes the sparse annotations in NTFS.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-09-28 21:32:42 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-28 21:32:42 +01:00
@@ -48,9 +48,9 @@
 	  Affected files are fs/ntfs/layout.h, logfile.h, and time.h.
 	- Do proper type casting when using ntfs_is_*_recordp() in
 	  fs/ntfs/logfile.c, mft.c, and super.c. 
-	- Fix all the sparse bitwise warnings.  Had to change all the enums
-	  storing little endian values to #defines because we cannot set enums
-	  to be little endian so we had lots of bitwise warnings from sparse.
+	- Fix all the sparse bitwise warnings.  Had to change all the typedef
+	  enums storing little endian values to simple enums plus a typedef for
+	  the datatype to make sparse happy.
 	- Fix a bug found by the new sparse bitwise warnings where the default
 	  upcase table was defined as a pointer to wchar_t rather than ntfschar
 	  in fs/ntfs/ntfs.h and super.c.
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-09-28 21:32:42 +01:00
+++ b/fs/ntfs/layout.h	2004-09-28 21:32:42 +01:00
@@ -112,28 +112,29 @@
  * Magic identifiers present at the beginning of all ntfs record containing
  * records (like mft records for example).
  */
-/* Found in $MFT/$DATA. */
-#define magic_FILE const_cpu_to_le32(0x454c4946) /* Mft entry. */
-#define magic_INDX const_cpu_to_le32(0x58444e49) /* Index buffer. */
-#define magic_HOLE const_cpu_to_le32(0x454c4f48) /* ? (NTFS 3.0+?) */
-
-/* Found in $LogFile/$DATA. */
-#define magic_RSTR const_cpu_to_le32(0x52545352) /* Restart page. */
-#define magic_RCRD const_cpu_to_le32(0x44524352) /* Log record page. */
-
-/* Found in $LogFile/$DATA.  (May be found in $MFT/$DATA, also?) */
-#define magic_CHKD const_cpu_to_le32(0x424b4843) /* Modified by chkdsk. */
-
-/* Found in all ntfs record containing records. */
-#define magic_BAAD const_cpu_to_le32(0x44414142) /* Failed multi sector
-						    transfer was detected. */
-/*
- * Found in $LogFile/$DATA when a page is full or 0xff bytes and is thus not
- * initialized.  User has to initialize the page before using it.
- */
-#define magic_empty const_cpu_to_le32(0xffffffff)/* Record is empty and has to
-						    be initialized before it
-						    can be used. */
+enum {
+	/* Found in $MFT/$DATA. */
+	magic_FILE = const_cpu_to_le32(0x454c4946), /* Mft entry. */
+	magic_INDX = const_cpu_to_le32(0x58444e49), /* Index buffer. */
+	magic_HOLE = const_cpu_to_le32(0x454c4f48), /* ? (NTFS 3.0+?) */
+
+	/* Found in $LogFile/$DATA. */
+	magic_RSTR = const_cpu_to_le32(0x52545352), /* Restart page. */
+	magic_RCRD = const_cpu_to_le32(0x44524352), /* Log record page. */
+
+	/* Found in $LogFile/$DATA.  (May be found in $MFT/$DATA, also?) */
+	magic_CHKD = const_cpu_to_le32(0x424b4843), /* Modified by chkdsk. */
+
+	/* Found in all ntfs record containing records. */
+	magic_BAAD = const_cpu_to_le32(0x44414142), /* Failed multi sector
+						       transfer was detected. */
+	/*
+	 * Found in $LogFile/$DATA when a page is full of 0xff bytes and is
+	 * thus not initialized.  Page must be initialized before using it.
+	 */
+	magic_empty = const_cpu_to_le32(0xffffffff) /* Record is empty. */
+};
+
 typedef le32 NTFS_RECORD_TYPE;
 
 /*
@@ -256,8 +257,10 @@
  * These are the so far known MFT_RECORD_* flags (16-bit) which contain
  * information about the mft record in which they are present.
  */
-#define MFT_RECORD_IN_USE	const_cpu_to_le16(0x0001)
-#define MFT_RECORD_IS_DIRECTORY	const_cpu_to_le16(0x0002)
+enum {
+	MFT_RECORD_IN_USE	= const_cpu_to_le16(0x0001),
+	MFT_RECORD_IS_DIRECTORY = const_cpu_to_le16(0x0002),
+};
 
 typedef le16 MFT_RECORD_FLAGS;
 
@@ -406,25 +409,27 @@
  * in the below defines exchanging AT_ for the dollar sign ($).  If that is not
  * a revealing choice of symbol I do not know what is... (-;
  */
-#define AT_UNUSED			const_cpu_to_le32(         0)
-#define AT_STANDARD_INFORMATION		const_cpu_to_le32(      0x10)
-#define AT_ATTRIBUTE_LIST		const_cpu_to_le32(      0x20)
-#define AT_FILE_NAME			const_cpu_to_le32(      0x30)
-#define AT_OBJECT_ID			const_cpu_to_le32(      0x40)
-#define AT_SECURITY_DESCRIPTOR		const_cpu_to_le32(      0x50)
-#define AT_VOLUME_NAME			const_cpu_to_le32(      0x60)
-#define AT_VOLUME_INFORMATION		const_cpu_to_le32(      0x70)
-#define AT_DATA				const_cpu_to_le32(      0x80)
-#define AT_INDEX_ROOT			const_cpu_to_le32(      0x90)
-#define AT_INDEX_ALLOCATION		const_cpu_to_le32(      0xa0)
-#define AT_BITMAP			const_cpu_to_le32(      0xb0)
-#define AT_REPARSE_POINT		const_cpu_to_le32(      0xc0)
-#define AT_EA_INFORMATION		const_cpu_to_le32(      0xd0)
-#define AT_EA				const_cpu_to_le32(      0xe0)
-#define AT_PROPERTY_SET			const_cpu_to_le32(      0xf0)
-#define AT_LOGGED_UTILITY_STREAM	const_cpu_to_le32(     0x100)
-#define AT_FIRST_USER_DEFINED_ATTRIBUTE	const_cpu_to_le32(    0x1000)
-#define AT_END				const_cpu_to_le32(0xffffffff)
+enum {
+	AT_UNUSED			= const_cpu_to_le32(         0),
+	AT_STANDARD_INFORMATION		= const_cpu_to_le32(      0x10),
+	AT_ATTRIBUTE_LIST		= const_cpu_to_le32(      0x20),
+	AT_FILE_NAME			= const_cpu_to_le32(      0x30),
+	AT_OBJECT_ID			= const_cpu_to_le32(      0x40),
+	AT_SECURITY_DESCRIPTOR		= const_cpu_to_le32(      0x50),
+	AT_VOLUME_NAME			= const_cpu_to_le32(      0x60),
+	AT_VOLUME_INFORMATION		= const_cpu_to_le32(      0x70),
+	AT_DATA				= const_cpu_to_le32(      0x80),
+	AT_INDEX_ROOT			= const_cpu_to_le32(      0x90),
+	AT_INDEX_ALLOCATION		= const_cpu_to_le32(      0xa0),
+	AT_BITMAP			= const_cpu_to_le32(      0xb0),
+	AT_REPARSE_POINT		= const_cpu_to_le32(      0xc0),
+	AT_EA_INFORMATION		= const_cpu_to_le32(      0xd0),
+	AT_EA				= const_cpu_to_le32(      0xe0),
+	AT_PROPERTY_SET			= const_cpu_to_le32(      0xf0),
+	AT_LOGGED_UTILITY_STREAM	= const_cpu_to_le32(     0x100),
+	AT_FIRST_USER_DEFINED_ATTRIBUTE	= const_cpu_to_le32(    0x1000),
+	AT_END				= const_cpu_to_le32(0xffffffff)
+};
 
 typedef le32 ATTR_TYPE;
 
@@ -466,13 +471,15 @@
  *	the 2nd object_id. If the first le32 values of both object_ids were
  *	equal then the second le32 values would be compared, etc.
  */
-#define COLLATION_BINARY		const_cpu_to_le32(0x00)
-#define COLLATION_FILE_NAME		const_cpu_to_le32(0x01)
-#define COLLATION_UNICODE_STRING	const_cpu_to_le32(0x02)
-#define COLLATION_NTOFS_ULONG		const_cpu_to_le32(0x10)
-#define COLLATION_NTOFS_SID		const_cpu_to_le32(0x11)
-#define COLLATION_NTOFS_SECURITY_HASH	const_cpu_to_le32(0x12)
-#define COLLATION_NTOFS_ULONGS		const_cpu_to_le32(0x13)
+enum {
+	COLLATION_BINARY		= const_cpu_to_le32(0x00),
+	COLLATION_FILE_NAME		= const_cpu_to_le32(0x01),
+	COLLATION_UNICODE_STRING	= const_cpu_to_le32(0x02),
+	COLLATION_NTOFS_ULONG		= const_cpu_to_le32(0x10),
+	COLLATION_NTOFS_SID		= const_cpu_to_le32(0x11),
+	COLLATION_NTOFS_SECURITY_HASH	= const_cpu_to_le32(0x12),
+	COLLATION_NTOFS_ULONGS		= const_cpu_to_le32(0x13)
+};
 
 typedef le32 COLLATION_RULE;
 
@@ -483,13 +490,15 @@
  * The INDEXABLE flag is fairly certainly correct as only the file name
  * attribute has this flag set and this is the only attribute indexed in NT4.
  */
-#define INDEXABLE	    const_cpu_to_le32(0x02) /* Attribute can be
-						       indexed. */
-#define NEED_TO_REGENERATE  const_cpu_to_le32(0x40) /* Need to regenerate
-						       during regeneration
-						       phase. */
-#define CAN_BE_NON_RESIDENT const_cpu_to_le32(0x80) /* Attribute can be
-						       non-resident. */
+enum {
+	INDEXABLE	    = const_cpu_to_le32(0x02), /* Attribute can be
+							  indexed. */
+	NEED_TO_REGENERATE  = const_cpu_to_le32(0x40), /* Need to regenerate
+							  during regeneration
+							  phase. */
+	CAN_BE_NON_RESIDENT = const_cpu_to_le32(0x80), /* Attribute can be
+							  non-resident. */
+};
 
 typedef le32 ATTR_DEF_FLAGS;
 
@@ -519,12 +528,14 @@
 /*
  * Attribute flags (16-bit).
  */
-#define ATTR_IS_COMPRESSED    const_cpu_to_le16(0x0001)
-#define	ATTR_COMPRESSION_MASK const_cpu_to_le16(0x00ff) /* Compression method
-							   mask.  Also, first
-							   illegal value. */
-#define ATTR_IS_ENCRYPTED     const_cpu_to_le16(0x4000)
-#define ATTR_IS_SPARSE	      const_cpu_to_le16(0x8000)
+enum {
+	ATTR_IS_COMPRESSED    = const_cpu_to_le16(0x0001),
+	ATTR_COMPRESSION_MASK = const_cpu_to_le16(0x00ff), /* Compression method
+							      mask.  Also, first
+							      illegal value. */
+	ATTR_IS_ENCRYPTED     = const_cpu_to_le16(0x4000),
+	ATTR_IS_SPARSE	      = const_cpu_to_le16(0x8000),
+} __attribute__ ((__packed__));
 
 typedef le16 ATTR_FLAGS;
 
@@ -598,9 +609,11 @@
 /*
  * Flags of resident attributes (8-bit).
  */
-#define RESIDENT_ATTR_IS_INDEXED 0x01 /* Attribute is referenced in an index
-					 (has implications for deleting and
-					 modifying the attribute). */
+enum {
+	RESIDENT_ATTR_IS_INDEXED = 0x01, /* Attribute is referenced in an index
+					    (has implications for deleting and
+					    modifying the attribute). */
+} __attribute__ ((__packed__));
 
 typedef u8 RESIDENT_ATTR_FLAGS;
 
@@ -703,54 +716,57 @@
 
 /*
  * File attribute flags (32-bit).
- *
- * The following flags are only present in the STANDARD_INFORMATION attribute
- * (in the field file_attributes).
  */
-#define	FILE_ATTR_READONLY		const_cpu_to_le32(0x00000001)
-#define	FILE_ATTR_HIDDEN		const_cpu_to_le32(0x00000002)
-#define	FILE_ATTR_SYSTEM		const_cpu_to_le32(0x00000004)
-/* Old DOS volid. Unused in NT.	= cpu_to_le32(0x00000008), */
-
-#define FILE_ATTR_DIRECTORY		const_cpu_to_le32(0x00000010)
-/* FILE_ATTR_DIRECTORY is not considered valid in NT.  It is reserved for the
-   DOS SUBDIRECTORY flag. */
-#define FILE_ATTR_ARCHIVE		const_cpu_to_le32(0x00000020)
-#define FILE_ATTR_DEVICE		const_cpu_to_le32(0x00000040)
-#define FILE_ATTR_NORMAL		const_cpu_to_le32(0x00000080)
-
-#define FILE_ATTR_TEMPORARY		const_cpu_to_le32(0x00000100)
-#define FILE_ATTR_SPARSE_FILE		const_cpu_to_le32(0x00000200)
-#define FILE_ATTR_REPARSE_POINT		const_cpu_to_le32(0x00000400)
-#define FILE_ATTR_COMPRESSED		const_cpu_to_le32(0x00000800)
-
-#define FILE_ATTR_OFFLINE		const_cpu_to_le32(0x00001000)
-#define FILE_ATTR_NOT_CONTENT_INDEXED	const_cpu_to_le32(0x00002000)
-#define FILE_ATTR_ENCRYPTED		const_cpu_to_le32(0x00004000)
-
-#define FILE_ATTR_VALID_FLAGS		const_cpu_to_le32(0x00007fb7)
-/* FILE_ATTR_VALID_FLAGS masks out the old DOS VolId and the FILE_ATTR_DEVICE
-   and preserves everything else.  This mask is used to obtain all flags that
-   are valid for reading. */
-#define FILE_ATTR_VALID_SET_FLAGS	const_cpu_to_le32(0x000031a7)
-/* FILE_ATTR_VALID_SET_FLAGS masks out the old DOS VolId, the F_A_DEVICE,
-   F_A_DIRECTORY, F_A_SPARSE_FILE, F_A_REPARSE_POINT, F_A_COMPRESSED, and
-   F_A_ENCRYPTED and preserves the rest.  This mask is used to to obtain all
-   flags that are valid for setting. */
-
-/*
- * The following flags are only present in the FILE_NAME attribute (in the
- * field file_attributes).
- */
-#define FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT	const_cpu_to_le32(0x10000000)
-/* This is a copy of the corresponding bit from the mft record, telling us
-   whether this is a directory or not, i.e. whether it has an index root
-   attribute or not. */
-#define FILE_ATTR_DUP_VIEW_INDEX_PRESENT	const_cpu_to_le32(0x20000000)
-/* This is a copy of the corresponding bit from the mft record, telling us
-   whether this file has a view index present (eg. object id index, quota
-   index, one of the security indexes or the encrypting file system related
-   indexes). */
+enum {
+	/*
+	 * The following flags are only present in the STANDARD_INFORMATION
+	 * attribute (in the field file_attributes).
+	 */
+	FILE_ATTR_READONLY		= const_cpu_to_le32(0x00000001),
+	FILE_ATTR_HIDDEN		= const_cpu_to_le32(0x00000002),
+	FILE_ATTR_SYSTEM		= const_cpu_to_le32(0x00000004),
+	/* Old DOS volid. Unused in NT.	= const_cpu_to_le32(0x00000008), */
+
+	FILE_ATTR_DIRECTORY		= const_cpu_to_le32(0x00000010),
+	/* Note, FILE_ATTR_DIRECTORY is not considered valid in NT.  It is
+	   reserved for the DOS SUBDIRECTORY flag. */
+	FILE_ATTR_ARCHIVE		= const_cpu_to_le32(0x00000020),
+	FILE_ATTR_DEVICE		= const_cpu_to_le32(0x00000040),
+	FILE_ATTR_NORMAL		= const_cpu_to_le32(0x00000080),
+
+	FILE_ATTR_TEMPORARY		= const_cpu_to_le32(0x00000100),
+	FILE_ATTR_SPARSE_FILE		= const_cpu_to_le32(0x00000200),
+	FILE_ATTR_REPARSE_POINT		= const_cpu_to_le32(0x00000400),
+	FILE_ATTR_COMPRESSED		= const_cpu_to_le32(0x00000800),
+
+	FILE_ATTR_OFFLINE		= const_cpu_to_le32(0x00001000),
+	FILE_ATTR_NOT_CONTENT_INDEXED	= const_cpu_to_le32(0x00002000),
+	FILE_ATTR_ENCRYPTED		= const_cpu_to_le32(0x00004000),
+
+	FILE_ATTR_VALID_FLAGS		= const_cpu_to_le32(0x00007fb7),
+	/* Note, FILE_ATTR_VALID_FLAGS masks out the old DOS VolId and the
+	   FILE_ATTR_DEVICE and preserves everything else.  This mask is used
+	   to obtain all flags that are valid for reading. */
+	FILE_ATTR_VALID_SET_FLAGS	= const_cpu_to_le32(0x000031a7),
+	/* Note, FILE_ATTR_VALID_SET_FLAGS masks out the old DOS VolId, the
+	   F_A_DEVICE, F_A_DIRECTORY, F_A_SPARSE_FILE, F_A_REPARSE_POINT,
+	   F_A_COMPRESSED, and F_A_ENCRYPTED and preserves the rest.  This mask
+	   is used to to obtain all flags that are valid for setting. */
+
+	/*
+	 * The following flags are only present in the FILE_NAME attribute (in
+	 * the field file_attributes).
+	 */
+	FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT	= const_cpu_to_le32(0x10000000),
+	/* Note, this is a copy of the corresponding bit from the mft record,
+	   telling us whether this is a directory or not, i.e. whether it has
+	   an index root attribute or not. */
+	FILE_ATTR_DUP_VIEW_INDEX_PRESENT	= const_cpu_to_le32(0x20000000),
+	/* Note, this is a copy of the corresponding bit from the mft record,
+	   telling us whether this file has a view index present (eg. object id
+	   index, quota index, one of the security indexes or the encrypting
+	   file system related indexes). */
+};
 
 typedef le32 FILE_ATTR_FLAGS;
 
@@ -923,24 +939,26 @@
 /*
  * Possible namespaces for filenames in ntfs (8-bit).
  */
-#define FILE_NAME_POSIX		0x00
+enum {
+	FILE_NAME_POSIX		= 0x00,
 	/* This is the largest namespace. It is case sensitive and allows all
 	   Unicode characters except for: '\0' and '/'.  Beware that in
 	   WinNT/2k files which eg have the same name except for their case
 	   will not be distinguished by the standard utilities and thus a "del
 	   filename" will delete both "filename" and "fileName" without
 	   warning. */
-#define FILE_NAME_WIN32		0x01
+	FILE_NAME_WIN32		= 0x01,
 	/* The standard WinNT/2k NTFS long filenames. Case insensitive.  All
 	   Unicode chars except: '\0', '"', '*', '/', ':', '<', '>', '?', '\',
 	   and '|'.  Further, names cannot end with a '.' or a space. */
-#define FILE_NAME_DOS		0x02
+	FILE_NAME_DOS		= 0x02,
 	/* The standard DOS filenames (8.3 format). Uppercase only.  All 8-bit
 	   characters greater space, except: '"', '*', '+', ',', '/', ':', ';',
 	   '<', '=', '>', '?', and '\'. */
-#define FILE_NAME_WIN32_AND_DOS	0x03
+	FILE_NAME_WIN32_AND_DOS	= 0x03,
 	/* 3 means that both the Win32 and the DOS filenames are identical and
 	   hence have been saved in this single filename record. */
+} __attribute__ ((__packed__));
 
 typedef u8 FILE_NAME_TYPE_FLAGS;
 
@@ -1248,29 +1266,30 @@
 /*
  * The predefined ACE types (8-bit, see below).
  */
-#define ACCESS_MIN_MS_ACE_TYPE			0
-#define ACCESS_ALLOWED_ACE_TYPE			0
-#define ACCESS_DENIED_ACE_TYPE			1
-#define SYSTEM_AUDIT_ACE_TYPE			2
-#define SYSTEM_ALARM_ACE_TYPE			3 /* Not implemented as of
-						     Win2k. */
-#define ACCESS_MAX_MS_V2_ACE_TYPE		3
-
-#define ACCESS_ALLOWED_COMPOUND_ACE_TYPE	4
-#define ACCESS_MAX_MS_V3_ACE_TYPE		4
-
-/* The following are Win2k only. */
-#define ACCESS_MIN_MS_OBJECT_ACE_TYPE		5
-#define ACCESS_ALLOWED_OBJECT_ACE_TYPE		5
-#define ACCESS_DENIED_OBJECT_ACE_TYPE		6
-#define SYSTEM_AUDIT_OBJECT_ACE_TYPE		7
-#define SYSTEM_ALARM_OBJECT_ACE_TYPE		8
-#define ACCESS_MAX_MS_OBJECT_ACE_TYPE		8
-
-#define ACCESS_MAX_MS_V4_ACE_TYPE		8
-
-/* This one is for WinNT/2k. */
-#define	ACCESS_MAX_MS_ACE_TYPE			8
+enum {
+	ACCESS_MIN_MS_ACE_TYPE		= 0,
+	ACCESS_ALLOWED_ACE_TYPE		= 0,
+	ACCESS_DENIED_ACE_TYPE		= 1,
+	SYSTEM_AUDIT_ACE_TYPE		= 2,
+	SYSTEM_ALARM_ACE_TYPE		= 3, /* Not implemented as of Win2k. */
+	ACCESS_MAX_MS_V2_ACE_TYPE	= 3,
+
+	ACCESS_ALLOWED_COMPOUND_ACE_TYPE= 4,
+	ACCESS_MAX_MS_V3_ACE_TYPE	= 4,
+
+	/* The following are Win2k only. */
+	ACCESS_MIN_MS_OBJECT_ACE_TYPE	= 5,
+	ACCESS_ALLOWED_OBJECT_ACE_TYPE	= 5,
+	ACCESS_DENIED_OBJECT_ACE_TYPE	= 6,
+	SYSTEM_AUDIT_OBJECT_ACE_TYPE	= 7,
+	SYSTEM_ALARM_OBJECT_ACE_TYPE	= 8,
+	ACCESS_MAX_MS_OBJECT_ACE_TYPE	= 8,
+
+	ACCESS_MAX_MS_V4_ACE_TYPE	= 8,
+
+	/* This one is for WinNT/2k. */
+	ACCESS_MAX_MS_ACE_TYPE		= 8,
+} __attribute__ ((__packed__));
 
 typedef u8 ACE_TYPES;
 
@@ -1284,17 +1303,19 @@
  * FAILED_ACCESS_ACE_FLAG is only used with system audit and alarm ACE types
  * to indicate that a message is generated (in Windows!) for failed accesses.
  */
-/* The inheritance flags. */
-#define OBJECT_INHERIT_ACE		0x01
-#define CONTAINER_INHERIT_ACE		0x02
-#define NO_PROPAGATE_INHERIT_ACE	0x04
-#define INHERIT_ONLY_ACE		0x08
-#define INHERITED_ACE			0x10	/* Win2k only. */
-#define VALID_INHERIT_FLAGS		0x1f
-
-/* The audit flags. */
-#define SUCCESSFUL_ACCESS_ACE_FLAG	0x40
-#define FAILED_ACCESS_ACE_FLAG		0x80
+enum {
+	/* The inheritance flags. */
+	OBJECT_INHERIT_ACE		= 0x01,
+	CONTAINER_INHERIT_ACE		= 0x02,
+	NO_PROPAGATE_INHERIT_ACE	= 0x04,
+	INHERIT_ONLY_ACE		= 0x08,
+	INHERITED_ACE			= 0x10,	/* Win2k only. */
+	VALID_INHERIT_FLAGS		= 0x1f,
+
+	/* The audit flags. */
+	SUCCESSFUL_ACCESS_ACE_FLAG	= 0x40,
+	FAILED_ACCESS_ACE_FLAG		= 0x80,
+} __attribute__ ((__packed__));
 
 typedef u8 ACE_FLAGS;
 
@@ -1322,129 +1343,130 @@
  * The specific rights (bits 0 to 15).  These depend on the type of the object
  * being secured by the ACE.
  */
+enum {
+	/* Specific rights for files and directories are as follows: */
 
-/* Specific rights for files and directories are as follows: */
-
-/* Right to read data from the file. (FILE) */
-#define FILE_READ_DATA			const_cpu_to_le32(0x00000001)
-/* Right to list contents of a directory. (DIRECTORY) */
-#define FILE_LIST_DIRECTORY		const_cpu_to_le32(0x00000001)
-
-/* Right to write data to the file. (FILE) */
-#define FILE_WRITE_DATA			const_cpu_to_le32(0x00000002)
-/* Right to create a file in the directory. (DIRECTORY) */
-#define FILE_ADD_FILE			const_cpu_to_le32(0x00000002)
-
-/* Right to append data to the file. (FILE) */
-#define FILE_APPEND_DATA		const_cpu_to_le32(0x00000004)
-/* Right to create a subdirectory. (DIRECTORY) */
-#define FILE_ADD_SUBDIRECTORY		const_cpu_to_le32(0x00000004)
-
-/* Right to read extended attributes. (FILE/DIRECTORY) */
-#define FILE_READ_EA			const_cpu_to_le32(0x00000008)
-
-/* Right to write extended attributes. (FILE/DIRECTORY) */
-#define FILE_WRITE_EA			const_cpu_to_le32(0x00000010)
-
-/* Right to execute a file. (FILE) */
-#define FILE_EXECUTE			const_cpu_to_le32(0x00000020)
-/* Right to traverse the directory. (DIRECTORY) */
-#define FILE_TRAVERSE			const_cpu_to_le32(0x00000020)
+	/* Right to read data from the file. (FILE) */
+	FILE_READ_DATA			= const_cpu_to_le32(0x00000001),
+	/* Right to list contents of a directory. (DIRECTORY) */
+	FILE_LIST_DIRECTORY		= const_cpu_to_le32(0x00000001),
+
+	/* Right to write data to the file. (FILE) */
+	FILE_WRITE_DATA			= const_cpu_to_le32(0x00000002),
+	/* Right to create a file in the directory. (DIRECTORY) */
+	FILE_ADD_FILE			= const_cpu_to_le32(0x00000002),
+
+	/* Right to append data to the file. (FILE) */
+	FILE_APPEND_DATA		= const_cpu_to_le32(0x00000004),
+	/* Right to create a subdirectory. (DIRECTORY) */
+	FILE_ADD_SUBDIRECTORY		= const_cpu_to_le32(0x00000004),
+
+	/* Right to read extended attributes. (FILE/DIRECTORY) */
+	FILE_READ_EA			= const_cpu_to_le32(0x00000008),
+
+	/* Right to write extended attributes. (FILE/DIRECTORY) */
+	FILE_WRITE_EA			= const_cpu_to_le32(0x00000010),
+
+	/* Right to execute a file. (FILE) */
+	FILE_EXECUTE			= const_cpu_to_le32(0x00000020),
+	/* Right to traverse the directory. (DIRECTORY) */
+	FILE_TRAVERSE			= const_cpu_to_le32(0x00000020),
 
-/*
- * Right to delete a directory and all the files it contains (its children),
- * even if the files are read-only. (DIRECTORY)
- */
-#define FILE_DELETE_CHILD		const_cpu_to_le32(0x00000040)
+	/*
+	 * Right to delete a directory and all the files it contains (its
+	 * children), even if the files are read-only. (DIRECTORY)
+	 */
+	FILE_DELETE_CHILD		= const_cpu_to_le32(0x00000040),
 
-/* Right to read file attributes. (FILE/DIRECTORY) */
-#define FILE_READ_ATTRIBUTES		const_cpu_to_le32(0x00000080)
+	/* Right to read file attributes. (FILE/DIRECTORY) */
+	FILE_READ_ATTRIBUTES		= const_cpu_to_le32(0x00000080),
 
-/* Right to change file attributes. (FILE/DIRECTORY) */
-#define FILE_WRITE_ATTRIBUTES		const_cpu_to_le32(0x00000100)
+	/* Right to change file attributes. (FILE/DIRECTORY) */
+	FILE_WRITE_ATTRIBUTES		= const_cpu_to_le32(0x00000100),
 
-/*
- * The standard rights (bits 16 to 23).  These are independent of the type of
- * object being secured.
- */
+	/*
+	 * The standard rights (bits 16 to 23).  These are independent of the
+	 * type of object being secured.
+	 */
 
-/* Right to delete the object. */
-#define DELETE				const_cpu_to_le32(0x00010000)
+	/* Right to delete the object. */
+	DELETE				= const_cpu_to_le32(0x00010000),
 
-/*
- * Right to read the information in the object's security descriptor, not
- * including the information in the SACL. I.e. right to read the security
- * descriptor and owner.
- */
-#define READ_CONTROL			const_cpu_to_le32(0x00020000)
+	/*
+	 * Right to read the information in the object's security descriptor,
+	 * not including the information in the SACL, i.e. right to read the
+	 * security descriptor and owner.
+	 */
+	READ_CONTROL			= const_cpu_to_le32(0x00020000),
 
-/* Right to modify the DACL in the object's security descriptor. */
-#define WRITE_DAC			const_cpu_to_le32(0x00040000)
+	/* Right to modify the DACL in the object's security descriptor. */
+	WRITE_DAC			= const_cpu_to_le32(0x00040000),
 
-/* Right to change the owner in the object's security descriptor. */
-#define WRITE_OWNER			const_cpu_to_le32(0x00080000)
+	/* Right to change the owner in the object's security descriptor. */
+	WRITE_OWNER			= const_cpu_to_le32(0x00080000),
 
-/*
- * Right to use the object for synchronization. Enables a process to wait until
- * the object is in the signalled state. Some object types do not support this
- * access right.
- */
-#define SYNCHRONIZE			const_cpu_to_le32(0x00100000)
+	/*
+	 * Right to use the object for synchronization.  Enables a process to
+	 * wait until the object is in the signalled state.  Some object types
+	 * do not support this access right.
+	 */
+	SYNCHRONIZE			= const_cpu_to_le32(0x00100000),
 
-/*
- * The following STANDARD_RIGHTS_* are combinations of the above for
- * convenience and are defined by the Win32 API.
- */
+	/*
+	 * The following STANDARD_RIGHTS_* are combinations of the above for
+	 * convenience and are defined by the Win32 API.
+	 */
 
-/* These are currently defined to READ_CONTROL. */
-#define STANDARD_RIGHTS_READ		const_cpu_to_le32(0x00020000)
-#define STANDARD_RIGHTS_WRITE		const_cpu_to_le32(0x00020000)
-#define STANDARD_RIGHTS_EXECUTE		const_cpu_to_le32(0x00020000)
+	/* These are currently defined to READ_CONTROL. */
+	STANDARD_RIGHTS_READ		= const_cpu_to_le32(0x00020000),
+	STANDARD_RIGHTS_WRITE		= const_cpu_to_le32(0x00020000),
+	STANDARD_RIGHTS_EXECUTE		= const_cpu_to_le32(0x00020000),
 
-/* Combines DELETE, READ_CONTROL, WRITE_DAC, and WRITE_OWNER access. */
-#define STANDARD_RIGHTS_REQUIRED	const_cpu_to_le32(0x000f0000)
+	/* Combines DELETE, READ_CONTROL, WRITE_DAC, and WRITE_OWNER access. */
+	STANDARD_RIGHTS_REQUIRED	= const_cpu_to_le32(0x000f0000),
 
-/*
- * Combines DELETE, READ_CONTROL, WRITE_DAC, WRITE_OWNER, and
- * SYNCHRONIZE access.
- */
-#define STANDARD_RIGHTS_ALL		const_cpu_to_le32(0x001f0000)
+	/*
+	 * Combines DELETE, READ_CONTROL, WRITE_DAC, WRITE_OWNER, and
+	 * SYNCHRONIZE access.
+	 */
+	STANDARD_RIGHTS_ALL		= const_cpu_to_le32(0x001f0000),
 
-/*
- * The access system ACL and maximum allowed access types (bits 24 to
- * 25, bits 26 to 27 are reserved).
- */
-#define ACCESS_SYSTEM_SECURITY		const_cpu_to_le32(0x01000000)
-#define MAXIMUM_ALLOWED			const_cpu_to_le32(0x02000000)
+	/*
+	 * The access system ACL and maximum allowed access types (bits 24 to
+	 * 25, bits 26 to 27 are reserved).
+	 */
+	ACCESS_SYSTEM_SECURITY		= const_cpu_to_le32(0x01000000),
+	MAXIMUM_ALLOWED			= const_cpu_to_le32(0x02000000),
 
-/*
- * The generic rights (bits 28 to 31). These map onto the standard and specific
- * rights.
- */
+	/*
+	 * The generic rights (bits 28 to 31).  These map onto the standard and
+	 * specific rights.
+	 */
 
-/* Read, write, and execute access. */
-#define GENERIC_ALL			const_cpu_to_le32(0x10000000)
+	/* Read, write, and execute access. */
+	GENERIC_ALL			= const_cpu_to_le32(0x10000000),
 
-/* Execute access. */
-#define GENERIC_EXECUTE			const_cpu_to_le32(0x20000000)
+	/* Execute access. */
+	GENERIC_EXECUTE			= const_cpu_to_le32(0x20000000),
 
-/*
- * Write access. For files, this maps onto:
- *	FILE_APPEND_DATA | FILE_WRITE_ATTRIBUTES | FILE_WRITE_DATA |
- *	FILE_WRITE_EA | STANDARD_RIGHTS_WRITE | SYNCHRONIZE
- * For directories, the mapping has the same numberical value.  See above for
- * the descriptions of the rights granted.
- */
-#define GENERIC_WRITE			const_cpu_to_le32(0x40000000)
+	/*
+	 * Write access.  For files, this maps onto:
+	 *	FILE_APPEND_DATA | FILE_WRITE_ATTRIBUTES | FILE_WRITE_DATA |
+	 *	FILE_WRITE_EA | STANDARD_RIGHTS_WRITE | SYNCHRONIZE
+	 * For directories, the mapping has the same numerical value.  See
+	 * above for the descriptions of the rights granted.
+	 */
+	GENERIC_WRITE			= const_cpu_to_le32(0x40000000),
 
-/*
- * Read access. For files, this maps onto:
- *	FILE_READ_ATTRIBUTES | FILE_READ_DATA | FILE_READ_EA |
- *	STANDARD_RIGHTS_READ | SYNCHRONIZE
- * For directories, the mapping has the same numberical value.  See above for
- * the descriptions of the rights granted.
- */
-#define GENERIC_READ			const_cpu_to_le32(0x80000000)
+	/*
+	 * Read access.  For files, this maps onto:
+	 *	FILE_READ_ATTRIBUTES | FILE_READ_DATA | FILE_READ_EA |
+	 *	STANDARD_RIGHTS_READ | SYNCHRONIZE
+	 * For directories, the mapping has the same numberical value.  See
+	 * above for the descriptions of the rights granted.
+	 */
+	GENERIC_READ			= const_cpu_to_le32(0x80000000),
+};
 
 typedef le32 ACCESS_MASK;
 
@@ -1482,8 +1504,10 @@
 /*
  * The object ACE flags (32-bit).
  */
-#define ACE_OBJECT_TYPE_PRESENT			const_cpu_to_le32(1)
-#define ACE_INHERITED_OBJECT_TYPE_PRESENT	const_cpu_to_le32(2)
+enum {
+	ACE_OBJECT_TYPE_PRESENT			= const_cpu_to_le32(1),
+	ACE_INHERITED_OBJECT_TYPE_PRESENT	= const_cpu_to_le32(2),
+};
 
 typedef le32 OBJECT_ACE_FLAGS;
 
@@ -1582,20 +1606,25 @@
  *	security descriptor are contiguous in memory and all pointer fields are
  *	expressed as offsets from the beginning of the security descriptor.
  */
-#define SE_OWNER_DEFAULTED		const_cpu_to_le16(0x0001)
-#define SE_GROUP_DEFAULTED		const_cpu_to_le16(0x0002)
-#define SE_DACL_PRESENT			const_cpu_to_le16(0x0004)
-#define SE_DACL_DEFAULTED		const_cpu_to_le16(0x0008)
-#define SE_SACL_PRESENT			const_cpu_to_le16(0x0010)
-#define SE_SACL_DEFAULTED		const_cpu_to_le16(0x0020)
-#define SE_DACL_AUTO_INHERIT_REQ	const_cpu_to_le16(0x0100)
-#define SE_SACL_AUTO_INHERIT_REQ	const_cpu_to_le16(0x0200)
-#define SE_DACL_AUTO_INHERITED		const_cpu_to_le16(0x0400)
-#define SE_SACL_AUTO_INHERITED		const_cpu_to_le16(0x0800)
-#define SE_DACL_PROTECTED		const_cpu_to_le16(0x1000)
-#define SE_SACL_PROTECTED		const_cpu_to_le16(0x2000)
-#define SE_RM_CONTROL_VALID		const_cpu_to_le16(0x4000)
-#define SE_SELF_RELATIVE		const_cpu_to_le16(0x8000)
+enum {
+	SE_OWNER_DEFAULTED		= const_cpu_to_le16(0x0001),
+	SE_GROUP_DEFAULTED		= const_cpu_to_le16(0x0002),
+	SE_DACL_PRESENT			= const_cpu_to_le16(0x0004),
+	SE_DACL_DEFAULTED		= const_cpu_to_le16(0x0008),
+
+	SE_SACL_PRESENT			= const_cpu_to_le16(0x0010),
+	SE_SACL_DEFAULTED		= const_cpu_to_le16(0x0020),
+
+	SE_DACL_AUTO_INHERIT_REQ	= const_cpu_to_le16(0x0100),
+	SE_SACL_AUTO_INHERIT_REQ	= const_cpu_to_le16(0x0200),
+	SE_DACL_AUTO_INHERITED		= const_cpu_to_le16(0x0400),
+	SE_SACL_AUTO_INHERITED		= const_cpu_to_le16(0x0800),
+
+	SE_DACL_PROTECTED		= const_cpu_to_le16(0x1000),
+	SE_SACL_PROTECTED		= const_cpu_to_le16(0x2000),
+	SE_RM_CONTROL_VALID		= const_cpu_to_le16(0x4000),
+	SE_SELF_RELATIVE		= const_cpu_to_le16(0x8000)
+} __attribute__ ((__packed__));
 
 typedef le16 SECURITY_DESCRIPTOR_CONTROL;
 
@@ -1781,17 +1810,22 @@
 /*
  * Possible flags for the volume (16-bit).
  */
-#define VOLUME_IS_DIRTY			const_cpu_to_le16(0x0001)
-#define VOLUME_RESIZE_LOG_FILE		const_cpu_to_le16(0x0002)
-#define VOLUME_UPGRADE_ON_MOUNT		const_cpu_to_le16(0x0004)
-#define VOLUME_MOUNTED_ON_NT4		const_cpu_to_le16(0x0008)
-#define VOLUME_DELETE_USN_UNDERWAY	const_cpu_to_le16(0x0010)
-#define VOLUME_REPAIR_OBJECT_ID		const_cpu_to_le16(0x0020)
-#define VOLUME_MODIFIED_BY_CHKDSK	const_cpu_to_le16(0x8000)
-#define VOLUME_FLAGS_MASK		const_cpu_to_le16(0x803f)
-
-/* To make our life easier when checking if we must mount read-only. */
-#define VOLUME_MUST_MOUNT_RO_MASK	const_cpu_to_le16(0x8037)
+enum {
+	VOLUME_IS_DIRTY			= const_cpu_to_le16(0x0001),
+	VOLUME_RESIZE_LOG_FILE		= const_cpu_to_le16(0x0002),
+	VOLUME_UPGRADE_ON_MOUNT		= const_cpu_to_le16(0x0004),
+	VOLUME_MOUNTED_ON_NT4		= const_cpu_to_le16(0x0008),
+
+	VOLUME_DELETE_USN_UNDERWAY	= const_cpu_to_le16(0x0010),
+	VOLUME_REPAIR_OBJECT_ID		= const_cpu_to_le16(0x0020),
+
+	VOLUME_MODIFIED_BY_CHKDSK	= const_cpu_to_le16(0x8000),
+
+	VOLUME_FLAGS_MASK		= const_cpu_to_le16(0x803f),
+
+	/* To make our life easier when checking if we must mount read-only. */
+	VOLUME_MUST_MOUNT_RO_MASK	= const_cpu_to_le16(0x8037),
+} __attribute__ ((__packed__));
 
 typedef le16 VOLUME_FLAGS;
 
@@ -1823,24 +1857,27 @@
 
 /*
  * Index header flags (8-bit).
- *
- * When index header is in an index root attribute:
  */
-#define SMALL_INDEX 0 /* The index is small enough to fit inside the index root
-			 attribute and there is no index allocation attribute
-			 present. */
-#define LARGE_INDEX 1 /* The index is too large to fit in the index root
-			 attribute and/or an index allocation attribute is
-			 present. */
-/*
- * When index header is in an index block, i.e. is part of index allocation
- * attribute:
- */
-#define LEAF_NODE  0 /* This is a leaf node, i.e. there are no more nodes
-			branching off it. */
-#define INDEX_NODE 1 /* This node indexes other nodes, i.e. it is not a leaf
-			node. */
-#define NODE_MASK  1 /* Mask for accessing the *_NODE bits. */
+enum {
+	/*
+	 * When index header is in an index root attribute:
+	 */
+	SMALL_INDEX = 0, /* The index is small enough to fit inside the index
+			    root attribute and there is no index allocation
+			    attribute present. */
+	LARGE_INDEX = 1, /* The index is too large to fit in the index root
+			    attribute and/or an index allocation attribute is
+			    present. */
+	/*
+	 * When index header is in an index block, i.e. is part of index
+	 * allocation attribute:
+	 */
+	LEAF_NODE  = 0, /* This is a leaf node, i.e. there are no more nodes
+			   branching off it. */
+	INDEX_NODE = 1, /* This node indexes other nodes, i.e. it is not a leaf
+			   node. */
+	NODE_MASK  = 1, /* Mask for accessing the *_NODE bits. */
+} __attribute__ ((__packed__));
 
 typedef u8 INDEX_HEADER_FLAGS;
 
@@ -1971,23 +2008,28 @@
  *
  * The user quota flags.  Names explain meaning.
  */
-#define QUOTA_FLAG_DEFAULT_LIMITS	const_cpu_to_le32(0x00000001)
-#define QUOTA_FLAG_LIMIT_REACHED	const_cpu_to_le32(0x00000002)
-#define QUOTA_FLAG_ID_DELETED		const_cpu_to_le32(0x00000004)
-
-#define QUOTA_FLAG_USER_MASK		const_cpu_to_le32(0x00000007)
-	/* Bit mask for user quota flags. */
-
-/* These flags are only present in the quota defaults index entry, i.e. in the
-   entry where owner_id = QUOTA_DEFAULTS_ID. */
-#define QUOTA_FLAG_TRACKING_ENABLED	const_cpu_to_le32(0x00000010)
-#define QUOTA_FLAG_ENFORCEMENT_ENABLED	const_cpu_to_le32(0x00000020)
-#define QUOTA_FLAG_TRACKING_REQUESTED	const_cpu_to_le32(0x00000040)
-#define QUOTA_FLAG_LOG_THRESHOLD	const_cpu_to_le32(0x00000080)
-#define QUOTA_FLAG_LOG_LIMIT		const_cpu_to_le32(0x00000100)
-#define QUOTA_FLAG_OUT_OF_DATE		const_cpu_to_le32(0x00000200)
-#define QUOTA_FLAG_CORRUPT		const_cpu_to_le32(0x00000400)
-#define QUOTA_FLAG_PENDING_DELETES	const_cpu_to_le32(0x00000800)
+enum {
+	QUOTA_FLAG_DEFAULT_LIMITS	= const_cpu_to_le32(0x00000001),
+	QUOTA_FLAG_LIMIT_REACHED	= const_cpu_to_le32(0x00000002),
+	QUOTA_FLAG_ID_DELETED		= const_cpu_to_le32(0x00000004),
+
+	QUOTA_FLAG_USER_MASK		= const_cpu_to_le32(0x00000007),
+	/* This is a bit mask for the user quota flags. */
+
+	/*
+	 * These flags are only present in the quota defaults index entry, i.e.
+	 * in the entry where owner_id = QUOTA_DEFAULTS_ID.
+	 */
+	QUOTA_FLAG_TRACKING_ENABLED	= const_cpu_to_le32(0x00000010),
+	QUOTA_FLAG_ENFORCEMENT_ENABLED	= const_cpu_to_le32(0x00000020),
+	QUOTA_FLAG_TRACKING_REQUESTED	= const_cpu_to_le32(0x00000040),
+	QUOTA_FLAG_LOG_THRESHOLD	= const_cpu_to_le32(0x00000080),
+
+	QUOTA_FLAG_LOG_LIMIT		= const_cpu_to_le32(0x00000100),
+	QUOTA_FLAG_OUT_OF_DATE		= const_cpu_to_le32(0x00000200),
+	QUOTA_FLAG_CORRUPT		= const_cpu_to_le32(0x00000400),
+	QUOTA_FLAG_PENDING_DELETES	= const_cpu_to_le32(0x00000800),
+};
 
 typedef le32 QUOTA_FLAGS;
 
@@ -2029,9 +2071,11 @@
 /*
  * Predefined owner_id values (32-bit).
  */
-#define QUOTA_INVALID_ID	const_cpu_to_le32(0x00000000)
-#define QUOTA_DEFAULTS_ID	const_cpu_to_le32(0x00000001)
-#define QUOTA_FIRST_USER_ID	const_cpu_to_le32(0x00000100)
+enum {
+	QUOTA_INVALID_ID	= const_cpu_to_le32(0x00000000),
+	QUOTA_DEFAULTS_ID	= const_cpu_to_le32(0x00000001),
+	QUOTA_FIRST_USER_ID	= const_cpu_to_le32(0x00000100),
+};
 
 /*
  * Current constants for quota control entries.
@@ -2044,12 +2088,17 @@
 /*
  * Index entry flags (16-bit).
  */
-#define INDEX_ENTRY_NODE const_cpu_to_le16(1) /* This entry contains a
+enum {
+	INDEX_ENTRY_NODE = const_cpu_to_le16(1), /* This entry contains a
 			sub-node, i.e. a reference to an index block in form of
 			a virtual cluster number (see below). */
-#define INDEX_ENTRY_END  const_cpu_to_le16(2) /* This signifies the last entry
-			in an index block.  The index entry does not represent
-			a file but it can point to a sub-node. */
+	INDEX_ENTRY_END  = const_cpu_to_le16(2), /* This signifies the last
+			entry in an index block.  The index entry does not
+			represent a file but it can point to a sub-node. */
+
+	INDEX_ENTRY_SPACE_FILLER = const_cpu_to_le16(0xffff), /* gcc: Force
+			enum bit width to 16-bit. */
+} __attribute__ ((__packed__));
 
 typedef le16 INDEX_ENTRY_FLAGS;
 
@@ -2184,26 +2233,28 @@
  *
  * These are the predefined reparse point tags:
  */
-#define IO_REPARSE_TAG_IS_ALIAS		const_cpu_to_le32(0x20000000)
-#define IO_REPARSE_TAG_IS_HIGH_LATENCY	const_cpu_to_le32(0x40000000)
-#define IO_REPARSE_TAG_IS_MICROSOFT	const_cpu_to_le32(0x80000000)
+enum {
+	IO_REPARSE_TAG_IS_ALIAS		= const_cpu_to_le32(0x20000000),
+	IO_REPARSE_TAG_IS_HIGH_LATENCY	= const_cpu_to_le32(0x40000000),
+	IO_REPARSE_TAG_IS_MICROSOFT	= const_cpu_to_le32(0x80000000),
 
-#define IO_REPARSE_TAG_RESERVED_ZERO	const_cpu_to_le32(0x00000000)
-#define IO_REPARSE_TAG_RESERVED_ONE	const_cpu_to_le32(0x00000001)
-#define IO_REPARSE_TAG_RESERVED_RANGE	const_cpu_to_le32(0x00000001)
+	IO_REPARSE_TAG_RESERVED_ZERO	= const_cpu_to_le32(0x00000000),
+	IO_REPARSE_TAG_RESERVED_ONE	= const_cpu_to_le32(0x00000001),
+	IO_REPARSE_TAG_RESERVED_RANGE	= const_cpu_to_le32(0x00000001),
 
-#define IO_REPARSE_TAG_NSS		const_cpu_to_le32(0x68000005)
-#define IO_REPARSE_TAG_NSS_RECOVER	const_cpu_to_le32(0x68000006)
-#define IO_REPARSE_TAG_SIS		const_cpu_to_le32(0x68000007)
-#define IO_REPARSE_TAG_DFS		const_cpu_to_le32(0x68000008)
+	IO_REPARSE_TAG_NSS		= const_cpu_to_le32(0x68000005),
+	IO_REPARSE_TAG_NSS_RECOVER	= const_cpu_to_le32(0x68000006),
+	IO_REPARSE_TAG_SIS		= const_cpu_to_le32(0x68000007),
+	IO_REPARSE_TAG_DFS		= const_cpu_to_le32(0x68000008),
 
-#define IO_REPARSE_TAG_MOUNT_POINT	const_cpu_to_le32(0x88000003)
+	IO_REPARSE_TAG_MOUNT_POINT	= const_cpu_to_le32(0x88000003),
 
-#define IO_REPARSE_TAG_HSM		const_cpu_to_le32(0xa8000004)
+	IO_REPARSE_TAG_HSM		= const_cpu_to_le32(0xa8000004),
 
-#define IO_REPARSE_TAG_SYMBOLIC_LINK	const_cpu_to_le32(0xe8000000)
+	IO_REPARSE_TAG_SYMBOLIC_LINK	= const_cpu_to_le32(0xe8000000),
 
-#define IO_REPARSE_TAG_VALID_VALUES	const_cpu_to_le32(0xe000ffff)
+	IO_REPARSE_TAG_VALID_VALUES	= const_cpu_to_le32(0xe000ffff),
+};
 
 /*
  * Attribute: Reparse point (0xc0).
@@ -2237,7 +2288,9 @@
 /*
  * Extended attribute flags (8-bit).
  */
-#define NEED_EA	0x80
+enum {
+	NEED_EA	= 0x80
+} __attribute__ ((__packed__));
 
 typedef u8 EA_FLAGS;
 
diff -Nru a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
--- a/fs/ntfs/logfile.h	2004-09-28 21:32:42 +01:00
+++ b/fs/ntfs/logfile.h	2004-09-28 21:32:42 +01:00
@@ -111,7 +111,10 @@
  * These are the so far known RESTART_AREA_* flags (16-bit) which contain
  * information about the log file in which they are present.
  */
-#define RESTART_VOLUME_IS_CLEAN	const_cpu_to_le16(0x0002)
+enum {
+	RESTART_VOLUME_IS_CLEAN	= const_cpu_to_le16(0x0002),
+	RESTART_SPACE_FILLER	= 0xffff, /* gcc: Force enum bit width to 16. */
+} __attribute__ ((__packed__));
 
 typedef le16 RESTART_AREA_FLAGS;
 
