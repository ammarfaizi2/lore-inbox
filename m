Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVAONew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVAONew (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVAONew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:34:52 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:4264 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262278AbVAON2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:28:06 -0500
Subject: [PATCH 3/6] cifs: enum conversion
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1105795614.9555.3.camel@localhost>
References: <1105795546.9555.2.camel@localhost>
	 <1105795614.9555.3.camel@localhost>
Date: Sat, 15 Jan 2005 15:28:02 +0200
Message-Id: <1105795682.9555.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert #defines to proper enums and remove duplicate symbols.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 asn1.c    |   72 +++--
 cifspdu.h |  798 ++++++++++++++++++++++++++++++++------------------------------
 2 files changed, 464 insertions(+), 406 deletions(-)

Index: 2.6/fs/cifs/asn1.c
===================================================================
--- 2.6.orig/fs/cifs/asn1.c	2005-01-15 15:07:18.115524784 +0200
+++ 2.6/fs/cifs/asn1.c	2005-01-15 15:07:20.647139920 +0200
@@ -34,46 +34,54 @@
  *****************************************************************************/
 
 /* Class */
-#define ASN1_UNI	0	/* Universal */
-#define ASN1_APL	1	/* Application */
-#define ASN1_CTX	2	/* Context */
-#define ASN1_PRV	3	/* Private */
+enum {
+	ASN1_UNI = 0,	/* Universal */
+	ASN1_APL = 1,	/* Application */
+	ASN1_CTX = 2,	/* Context */
+	ASN1_PRV = 3	/* Private */
+};
 
 /* Tag */
-#define ASN1_EOC	0	/* End Of Contents or N/A */
-#define ASN1_BOL	1	/* Boolean */
-#define ASN1_INT	2	/* Integer */
-#define ASN1_BTS	3	/* Bit String */
-#define ASN1_OTS	4	/* Octet String */
-#define ASN1_NUL	5	/* Null */
-#define ASN1_OJI	6	/* Object Identifier  */
-#define ASN1_OJD	7	/* Object Description */
-#define ASN1_EXT	8	/* External */
-#define ASN1_SEQ	16	/* Sequence */
-#define ASN1_SET	17	/* Set */
-#define ASN1_NUMSTR	18	/* Numerical String */
-#define ASN1_PRNSTR	19	/* Printable String */
-#define ASN1_TEXSTR	20	/* Teletext String */
-#define ASN1_VIDSTR	21	/* Video String */
-#define ASN1_IA5STR	22	/* IA5 String */
-#define ASN1_UNITIM	23	/* Universal Time */
-#define ASN1_GENTIM	24	/* General Time */
-#define ASN1_GRASTR	25	/* Graphical String */
-#define ASN1_VISSTR	26	/* Visible String */
-#define ASN1_GENSTR	27	/* General String */
+enum {
+	ASN1_EOC    = 0,	/* End Of Contents or N/A */
+	ASN1_BOL    = 1,	/* Boolean */
+	ASN1_INT    = 2,	/* Integer */
+	ASN1_BTS    = 3,	/* Bit String */
+	ASN1_OTS    = 4,	/* Octet String */
+	ASN1_NUL    = 5,	/* Null */
+	ASN1_OJI    = 6,	/* Object Identifier  */
+	ASN1_OJD    = 7,	/* Object Description */
+	ASN1_EXT    = 8,	/* External */
+	ASN1_SEQ    = 16,	/* Sequence */
+	ASN1_SET    = 17,	/* Set */
+	ASN1_NUMSTR = 18,	/* Numerical String */
+	ASN1_PRNSTR = 19,	/* Printable String */
+	ASN1_TEXSTR = 20,	/* Teletext String */
+	ASN1_VIDSTR = 21,	/* Video String */
+	ASN1_IA5STR = 22,	/* IA5 String */
+	ASN1_UNITIM = 23,	/* Universal Time */
+	ASN1_GENTIM = 24,	/* General Time */
+	ASN1_GRASTR = 25,	/* Graphical String */
+	ASN1_VISSTR = 26,	/* Visible String */
+	ASN1_GENSTR = 27	/* General String */
+};
 
 /* Primitive / Constructed methods*/
-#define ASN1_PRI	0	/* Primitive */
-#define ASN1_CON	1	/* Constructed */
+enum {
+	ASN1_PRI = 0,	/* Primitive */
+	ASN1_CON = 1	/* Constructed */
+};
 
 /*
  * Error codes.
  */
-#define ASN1_ERR_NOERROR		0
-#define ASN1_ERR_DEC_EMPTY		2
-#define ASN1_ERR_DEC_EOC_MISMATCH	3
-#define ASN1_ERR_DEC_LENGTH_MISMATCH	4
-#define ASN1_ERR_DEC_BADVALUE		5
+enum {
+	ASN1_ERR_NOERROR 		= 0,
+	ASN1_ERR_DEC_EMPTY		= 2,
+	ASN1_ERR_DEC_EOC_MISMATCH	= 3,
+	ASN1_ERR_DEC_LENGTH_MISMATCH	= 4,
+	ASN1_ERR_DEC_BADVALUE		= 5
+};
 
 #define SPNEGO_OID_LEN 7
 #define NTLMSSP_OID_LEN  10
Index: 2.6/fs/cifs/cifspdu.h
===================================================================
--- 2.6.orig/fs/cifs/cifspdu.h	2005-01-12 23:46:16.000000000 +0200
+++ 2.6/fs/cifs/cifspdu.h	2005-01-15 15:11:07.013726968 +0200
@@ -28,61 +28,62 @@
 #define BAD_PROT    CIFS_PROT+1
 
 /* SMB command codes */
-/* Some commands have minimal (wct=0,bcc=0), or uninteresting, responses
- (ie which include no useful data other than the SMB error code itself).
- Knowing this helps avoid response buffer allocations and copy in some cases */
-#define SMB_COM_CREATE_DIRECTORY      0x00 /* trivial response */
-#define SMB_COM_DELETE_DIRECTORY      0x01 /* trivial response */
-#define SMB_COM_CLOSE                 0x04 /* triv req/rsp, timestamp ignored */
-#define SMB_COM_DELETE                0x06 /* trivial response */
-#define SMB_COM_RENAME                0x07 /* trivial response */
-#define SMB_COM_LOCKING_ANDX          0x24 /* trivial response */
-#define SMB_COM_COPY                  0x29 /* trivial rsp, fail filename ignrd*/
-#define SMB_COM_READ_ANDX             0x2E
-#define SMB_COM_WRITE_ANDX            0x2F
-#define SMB_COM_TRANSACTION2          0x32
-#define SMB_COM_TRANSACTION2_SECONDARY 0x33
-#define SMB_COM_FIND_CLOSE2           0x34 /* trivial response */
-#define SMB_COM_TREE_DISCONNECT       0x71 /* trivial response */
-#define SMB_COM_NEGOTIATE             0x72
-#define SMB_COM_SESSION_SETUP_ANDX    0x73
-#define SMB_COM_LOGOFF_ANDX           0x74 /* trivial response */
-#define SMB_COM_TREE_CONNECT_ANDX     0x75
-#define SMB_COM_NT_TRANSACT           0xA0
-#define SMB_COM_NT_TRANSACT_SECONDARY 0xA1
-#define SMB_COM_NT_CREATE_ANDX        0xA2
-#define SMB_COM_NT_RENAME             0xA5 /* trivial response */
+/* Some commands have minimal (wct=0,bcc=0), or uninteresting, responses (ie
+ * which include no useful data other than the SMB error code itself). Knowing
+ * this helps avoid response buffer allocations and copy in some cases
+ */
+enum {
+	SMB_COM_CREATE_DIRECTORY      = 0x00, /* trivial response */
+	SMB_COM_DELETE_DIRECTORY      = 0x01, /* trivial response */
+	SMB_COM_CLOSE                 = 0x04, /* triv req/rsp, timestamp ignored */
+	SMB_COM_DELETE                = 0x06, /* trivial response */
+	SMB_COM_RENAME                = 0x07, /* trivial response */
+	SMB_COM_LOCKING_ANDX          = 0x24, /* trivial response */
+	SMB_COM_COPY                  = 0x29, /* trivial rsp, fail filename ignrd*/
+	SMB_COM_READ_ANDX             = 0x2E,
+	SMB_COM_WRITE_ANDX            = 0x2F,
+	SMB_COM_TRANSACTION2          = 0x32,
+	SMB_COM_TRANSACTION2_SECONDARY = 0x33,
+	SMB_COM_FIND_CLOSE2           = 0x34, /* trivial response */
+	SMB_COM_TREE_DISCONNECT       = 0x71, /* trivial response */
+	SMB_COM_NEGOTIATE             = 0x72,
+	SMB_COM_SESSION_SETUP_ANDX    = 0x73,
+	SMB_COM_LOGOFF_ANDX           = 0x74, /* trivial response */
+	SMB_COM_TREE_CONNECT_ANDX     = 0x75,
+	SMB_COM_NT_TRANSACT           = 0xA0,
+	SMB_COM_NT_TRANSACT_SECONDARY = 0xA1,
+	SMB_COM_NT_CREATE_ANDX        = 0xA2,
+	SMB_COM_NT_RENAME             = 0xA5 /* trivial response */
+};
 
 /* Transact2 subcommand codes */
-#define TRANS2_OPEN                   0x00
-#define TRANS2_FIND_FIRST             0x01
-#define TRANS2_FIND_NEXT              0x02
-#define TRANS2_QUERY_FS_INFORMATION   0x03
-#define TRANS2_QUERY_PATH_INFORMATION 0x05
-#define TRANS2_SET_PATH_INFORMATION   0x06
-#define TRANS2_QUERY_FILE_INFORMATION 0x07
-#define TRANS2_SET_FILE_INFORMATION   0x08
-#define TRANS2_GET_DFS_REFERRAL       0x10
-#define TRANS2_REPORT_DFS_INCOSISTENCY 0x11
+enum {
+	TRANS2_OPEN                   = 0x00,
+	TRANS2_FIND_FIRST             = 0x01,
+	TRANS2_FIND_NEXT              = 0x02,
+	TRANS2_QUERY_FS_INFORMATION   = 0x03,
+	TRANS2_QUERY_PATH_INFORMATION = 0x05,
+	TRANS2_SET_PATH_INFORMATION   = 0x06,
+	TRANS2_QUERY_FILE_INFORMATION = 0x07,
+	TRANS2_SET_FILE_INFORMATION   = 0x08,
+	TRANS2_GET_DFS_REFERRAL       = 0x10,
+	TRANS2_REPORT_DFS_INCOSISTENCY = 0x11
+};
 
 /* NT Transact subcommand codes */
-#define NT_TRANSACT_CREATE            0x01
-#define NT_TRANSACT_IOCTL             0x02
-#define NT_TRANSACT_SET_SECURITY_DESC 0x03
-#define NT_TRANSACT_NOTIFY_CHANGE     0x04
-#define NT_TRANSACT_RENAME            0x05
-#define NT_TRANSACT_QUERY_SECURITY_DESC 0x06
-#define NT_TRANSACT_GET_USER_QUOTA    0x07
-#define NT_TRANSACT_SET_USER_QUOTA    0x08
+enum {
+	NT_TRANSACT_CREATE            = 0x01,
+	NT_TRANSACT_IOCTL             = 0x02,
+	NT_TRANSACT_SET_SECURITY_DESC = 0x03,
+	NT_TRANSACT_NOTIFY_CHANGE     = 0x04,
+	NT_TRANSACT_RENAME            = 0x05,
+	NT_TRANSACT_QUERY_SECURITY_DESC = 0x06,
+	NT_TRANSACT_GET_USER_QUOTA    = 0x07,
+	NT_TRANSACT_SET_USER_QUOTA    = 0x08
+};
 
 #define MAX_CIFS_HDR_SIZE 256	/* chained NTCreateXReadX will probably be biggest */
 
-/* internal cifs vfs structures */
-/*****************************************************************
- * All constants go here
- *****************************************************************
- */
-
 /*
  * Starting value for maximum SMB size negotiation
  */
@@ -111,31 +112,37 @@
 /*
  * Flags on SMB open
  */
-#define SMBOPEN_WRITE_THROUGH 0x4000
-#define SMBOPEN_DENY_ALL      0x0010
-#define SMBOPEN_DENY_WRITE    0x0020
-#define SMBOPEN_DENY_READ     0x0030
-#define SMBOPEN_DENY_NONE     0x0040
-#define SMBOPEN_READ          0x0000
-#define SMBOPEN_WRITE         0x0001
-#define SMBOPEN_READWRITE     0x0002
-#define SMBOPEN_EXECUTE       0x0003
-
-#define SMBOPEN_OCREATE       0x0010
-#define SMBOPEN_OTRUNC        0x0002
-#define SMBOPEN_OAPPEND       0x0001
+enum {
+	SMBOPEN_WRITE_THROUGH = 0x4000,
+	SMBOPEN_DENY_ALL      = 0x0010,
+	SMBOPEN_DENY_WRITE    = 0x0020,
+	SMBOPEN_DENY_READ     = 0x0030,
+	SMBOPEN_DENY_NONE     = 0x0040,
+	SMBOPEN_READ          = 0x0000,
+	SMBOPEN_WRITE         = 0x0001,
+	SMBOPEN_READWRITE     = 0x0002,
+	SMBOPEN_EXECUTE       = 0x0003
+};
+
+enum {
+	SMBOPEN_OCREATE       = 0x0010,
+	SMBOPEN_OTRUNC        = 0x0002,
+	SMBOPEN_OAPPEND       = 0x0001
+};
 
 /*
  * SMB flag definitions 
  */
-#define SMBFLG_EXTD_LOCK 0x01	/* server supports lock-read write-unlock primitives */
-#define SMBFLG_RCV_POSTED 0x02	/* obsolete */
-#define SMBFLG_RSVD 0x04
-#define SMBFLG_CASELESS 0x08	/* all pathnames treated as caseless (off implies case sensitive file handling requested) */
-#define SMBFLG_CANONICAL_PATH_FORMAT 0x10	/* obsolete */
-#define SMBFLG_OLD_OPLOCK 0x20	/* obsolete */
-#define SMBFLG_OLD_OPLOCK_NOTIFY 0x40	/* obsolete */
-#define SMBFLG_RESPONSE 0x80	/* this PDU is a response from server */
+enum {
+	SMBFLG_EXTD_LOCK	= 0x01,  /* server supports lock-read write-unlock primitives */
+	SMBFLG_RCV_POSTED	= 0x02,	 /* obsolete */
+	SMBFLG_RSVD		= 0x04,
+	SMBFLG_CASELESS		= 0x08,	 /* all pathnames treated as caseless (off implies case sensitive file handling requested) */
+	SMBFLG_CANONICAL_PATH_FORMAT = 0x10, /* obsolete */
+	SMBFLG_OLD_OPLOCK	= 0x20,	 /* obsolete */
+	SMBFLG_OLD_OPLOCK_NOTIFY = 0x40, /* obsolete */
+	SMBFLG_RESPONSE		= 0x80 	 /* this PDU is a response from server */
+};
 
 /*
  * SMB flag2 definitions 
@@ -159,41 +166,43 @@
  * file and can have any suitable combination of the following values:
  */
 
-#define FILE_READ_DATA        0x00000001	/* Data can be read from the file   */
-#define FILE_WRITE_DATA       0x00000002	/* Data can be written to the file  */
-#define FILE_APPEND_DATA      0x00000004	/* Data can be appended to the file */
-#define FILE_READ_EA          0x00000008	/* Extended attributes associated   */
-					 /* with the file can be read        */
-#define FILE_WRITE_EA         0x00000010	/* Extended attributes associated   */
-					 /* with the file can be written     */
-#define FILE_EXECUTE          0x00000020	/*Data can be read into memory from */
-					 /* the file using system paging I/O */
-#define FILE_DELETE_CHILD     0x00000040
-#define FILE_READ_ATTRIBUTES  0x00000080	/* Attributes associated with the   */
-					 /* file can be read                 */
-#define FILE_WRITE_ATTRIBUTES 0x00000100	/* Attributes associated with the   */
-					 /* file can be written              */
-#define DELETE                0x00010000	/* The file can be deleted          */
-#define READ_CONTROL          0x00020000	/* The access control list and      */
-					 /* ownership associated with the    */
-					 /* file can be read                 */
-#define WRITE_DAC             0x00040000	/* The access control list and      */
-					 /* ownership associated with the    */
-					 /* file can be written.             */
-#define WRITE_OWNER           0x00080000	/* Ownership information associated */
-					 /* with the file can be written     */
-#define SYNCHRONIZE           0x00100000	/* The file handle can waited on to */
-					 /* synchronize with the completion  */
-					 /* of an input/output request       */
-#define GENERIC_ALL           0x10000000
-#define GENERIC_EXECUTE       0x20000000
-#define GENERIC_WRITE         0x40000000
-#define GENERIC_READ          0x80000000
+enum {
+	FILE_READ_DATA        = 0x00000001, /* Data can be read from the file   */
+	FILE_WRITE_DATA       = 0x00000002, /* Data can be written to the file  */
+	FILE_APPEND_DATA      = 0x00000004, /* Data can be appended to the file */
+	FILE_READ_EA          = 0x00000008, /* Extended attributes associated   */
+					    /* with the file can be read        */
+	FILE_WRITE_EA         = 0x00000010, /* Extended attributes associated   */
+					    /* with the file can be written     */
+	FILE_EXECUTE          = 0x00000020, /* Data can be read into memory from */
+					    /* the file using system paging I/O */
+	FILE_DELETE_CHILD     = 0x00000040,
+	FILE_READ_ATTRIBUTES  = 0x00000080, /* Attributes associated with the   */
+					    /* file can be read                 */
+	FILE_WRITE_ATTRIBUTES = 0x00000100, /* Attributes associated with the   */
+					    /* file can be written              */
+	DELETE                = 0x00010000, /* The file can be deleted          */
+	READ_CONTROL          = 0x00020000, /* The access control list and      */
+					    /* ownership associated with the    */
+					    /* file can be read                 */
+	WRITE_DAC             = 0x00040000, /* The access control list and      */
+					    /* ownership associated with the    */
+					    /* file can be written.             */
+	WRITE_OWNER           = 0x00080000, /* Ownership information associated */
+					    /* with the file can be written     */
+	SYNCHRONIZE           = 0x00100000, /* The file handle can waited on to */
+					    /* synchronize with the completion  */
+					    /* of an input/output request       */
+	GENERIC_ALL           = 0x10000000,
+	GENERIC_EXECUTE       = 0x20000000,
+	GENERIC_WRITE         = 0x40000000,
+	GENERIC_READ          = 0x80000000
 					 /* In summary - Relevant file       */
 					 /* access flags from CIFS are       */
 					 /* file_read_data, file_write_data  */
 					 /* file_execute, file_read_attributes */
 					 /* write_dac, and delete.           */
+};
 
 /*
  * Invalid readdir handle
@@ -211,75 +220,91 @@
 #define ASCII_NULL 0x00
 
 /*
- * Server type values (returned on EnumServer API
+ * Server type values (returned on EnumServer API)
  */
-#define CIFS_SV_TYPE_DC     0x00000008
-#define CIFS_SV_TYPE_BACKDC 0x00000010
+enum {
+	CIFS_SV_TYPE_DC     = 0x00000008,
+	CIFS_SV_TYPE_BACKDC = 0x00000010
+};
 
 /*
- * Alias type flags (From EnumAlias API call
+ * Alias type flags (From EnumAlias API call)
  */
-#define CIFS_ALIAS_TYPE_FILE 0x0001
-#define CIFS_SHARE_TYPE_FILE 0x0000
+enum {
+	CIFS_ALIAS_TYPE_FILE = 0x0001,
+	CIFS_SHARE_TYPE_FILE = 0x0000
+};
 
 /*
  * File Attribute flags
  */
-#define ATTR_READONLY  0x0001
-#define ATTR_HIDDEN    0x0002
-#define ATTR_SYSTEM    0x0004
-#define ATTR_VOLUME    0x0008
-#define ATTR_DIRECTORY 0x0010
-#define ATTR_ARCHIVE   0x0020
-#define ATTR_DEVICE    0x0040
-#define ATTR_NORMAL    0x0080
-#define ATTR_TEMPORARY 0x0100
-#define ATTR_SPARSE    0x0200
-#define ATTR_REPARSE   0x0400
-#define ATTR_COMPRESSED 0x0800
-#define ATTR_OFFLINE    0x1000	/* ie file not immediately available - offline storage */
-#define ATTR_NOT_CONTENT_INDEXED 0x2000
-#define ATTR_ENCRYPTED  0x4000
-#define ATTR_POSIX_SEMANTICS 0x01000000
-#define ATTR_BACKUP_SEMANTICS 0x02000000
-#define ATTR_DELETE_ON_CLOSE 0x04000000
-#define ATTR_SEQUENTIAL_SCAN 0x08000000
-#define ATTR_RANDOM_ACCESS   0x10000000
-#define ATTR_NO_BUFFERING    0x20000000
-#define ATTR_WRITE_THROUGH   0x80000000
+enum {
+	 ATTR_READONLY		= 0x0001,
+	 ATTR_HIDDEN		= 0x0002,
+	 ATTR_SYSTEM		= 0x0004,
+	 ATTR_VOLUME		= 0x0008,
+	 ATTR_DIRECTORY		= 0x0010,
+	 ATTR_ARCHIVE		= 0x0020,
+	 ATTR_DEVICE		= 0x0040,
+	 ATTR_NORMAL		= 0x0080,
+	 ATTR_TEMPORARY		= 0x0100,
+	 ATTR_SPARSE		= 0x0200,
+	 ATTR_REPARSE		= 0x0400,
+	 ATTR_COMPRESSED	= 0x0800,
+	 ATTR_OFFLINE		= 0x1000, /* ie file not immediately available - offline storage */
+	 ATTR_NOT_CONTENT_INDEXED = 0x2000,
+	 ATTR_ENCRYPTED		= 0x4000,
+	 ATTR_POSIX_SEMANTICS	= 0x01000000,
+	 ATTR_BACKUP_SEMANTICS	= 0x02000000,
+	 ATTR_DELETE_ON_CLOSE	= 0x04000000,
+	 ATTR_SEQUENTIAL_SCAN	= 0x08000000,
+	 ATTR_RANDOM_ACCESS	= 0x10000000,
+	 ATTR_NO_BUFFERING	= 0x20000000,
+	 ATTR_WRITE_THROUGH	= 0x80000000
+};
 
 /* ShareAccess flags */
-#define FILE_NO_SHARE     0x00000000
-#define FILE_SHARE_READ   0x00000001
-#define FILE_SHARE_WRITE  0x00000002
-#define FILE_SHARE_DELETE 0x00000004
-#define FILE_SHARE_ALL    0x00000007
+enum {
+	 FILE_NO_SHARE     = 0x00000000,
+	 FILE_SHARE_READ   = 0x00000001,
+	 FILE_SHARE_WRITE  = 0x00000002,
+	 FILE_SHARE_DELETE = 0x00000004,
+	 FILE_SHARE_ALL    = 0x00000007
+};
 
 /* CreateDisposition flags */
-#define FILE_SUPERSEDE    0x00000000
-#define FILE_OPEN         0x00000001
-#define FILE_CREATE       0x00000002
-#define FILE_OPEN_IF      0x00000003
-#define FILE_OVERWRITE    0x00000004
-#define FILE_OVERWRITE_IF 0x00000005
+enum {
+	 FILE_SUPERSEDE    = 0x00000000,
+	 FILE_OPEN         = 0x00000001,
+	 FILE_CREATE       = 0x00000002,
+	 FILE_OPEN_IF      = 0x00000003,
+	 FILE_OVERWRITE    = 0x00000004,
+	 FILE_OVERWRITE_IF = 0x00000005
+};
 
 /* CreateOptions */
-#define CREATE_NOT_FILE		0x00000001	/* if set must not be file */
-#define CREATE_WRITE_THROUGH	0x00000002
-#define CREATE_NOT_DIR		0x00000040	/* if set must not be directory */
-#define CREATE_RANDOM_ACCESS	0x00000800
-#define CREATE_DELETE_ON_CLOSE	0x00001000
-#define OPEN_REPARSE_POINT	0x00200000
+enum {
+	 CREATE_NOT_FILE	= 0x00000001,	/* if set must not be file */
+	 CREATE_WRITE_THROUGH	= 0x00000002,
+	 CREATE_NOT_DIR		= 0x00000040,	/* if set must not be directory */
+	 CREATE_RANDOM_ACCESS	= 0x00000800,
+	 CREATE_DELETE_ON_CLOSE	= 0x00001000,
+	 OPEN_REPARSE_POINT	= 0x00200000
+};
 
 /* ImpersonationLevel flags */
-#define SECURITY_ANONYMOUS      0
-#define SECURITY_IDENTIFICATION 1
-#define SECURITY_IMPERSONATION  2
-#define SECURITY_DELEGATION     3
+enum {
+	 SECURITY_ANONYMOUS      = 0,
+	 SECURITY_IDENTIFICATION = 1,
+	 SECURITY_IMPERSONATION  = 2,
+	 SECURITY_DELEGATION     = 3,
+};
 
 /* SecurityFlags */
-#define SECURITY_CONTEXT_TRACKING 0x01
-#define SECURITY_EFFECTIVE_ONLY   0x02
+enum {
+	 SECURITY_CONTEXT_TRACKING = 0x01,
+	 SECURITY_EFFECTIVE_ONLY   = 0x02
+};
 
 /*
  * Default PID value, used in all SMBs where the PID is not important
@@ -290,8 +315,10 @@
  * We use the same routine for Copy and Move SMBs.  This flag is used to
  * distinguish
  */
-#define CIFS_COPY_OP 1
-#define CIFS_RENAME_OP 2
+enum {
+	 CIFS_COPY_OP   = 1,
+	 CIFS_RENAME_OP = 2
+};
 
 #define GETU16(var)  (*((__u16 *)var))	/* BB check for endian issues */
 #define GETU32(var)  (*((__u32 *)var))	/* BB check for endian issues */
@@ -408,31 +435,35 @@
 } NEGOTIATE_RSP;
 
 /* SecurityMode bits */
-#define SECMODE_USER          0x01	/* off indicates share level security */
-#define SECMODE_PW_ENCRYPT    0x02
-#define SECMODE_SIGN_ENABLED  0x04	/* SMB security signatures enabled */
-#define SECMODE_SIGN_REQUIRED 0x08	/* SMB security signatures required */
+enum {
+	 SECMODE_USER          = 0x01,	/* off indicates share level security */
+	 SECMODE_PW_ENCRYPT    = 0x02,
+	 SECMODE_SIGN_ENABLED  = 0x04,	/* SMB security signatures enabled */
+	 SECMODE_SIGN_REQUIRED = 0x08	/* SMB security signatures required */
+};
 
 /* Negotiate response Capabilities */
-#define CAP_RAW_MODE           0x00000001
-#define CAP_MPX_MODE           0x00000002
-#define CAP_UNICODE            0x00000004
-#define CAP_LARGE_FILES        0x00000008
-#define CAP_NT_SMBS            0x00000010	/* implies CAP_NT_FIND */
-#define CAP_RPC_REMOTE_APIS    0x00000020
-#define CAP_STATUS32           0x00000040
-#define CAP_LEVEL_II_OPLOCKS   0x00000080
-#define CAP_LOCK_AND_READ      0x00000100
-#define CAP_NT_FIND            0x00000200
-#define CAP_DFS                0x00001000
-#define CAP_INFOLEVEL_PASSTHRU 0x00002000
-#define CAP_LARGE_READ_X       0x00004000
-#define CAP_LARGE_WRITE_X      0x00008000
-#define CAP_UNIX               0x00800000
-#define CAP_RESERVED           0x02000000
-#define CAP_BULK_TRANSFER      0x20000000
-#define CAP_COMPRESSED_DATA    0x40000000
-#define CAP_EXTENDED_SECURITY  0x80000000
+enum {
+	 CAP_RAW_MODE           = 0x00000001,
+	 CAP_MPX_MODE           = 0x00000002,
+	 CAP_UNICODE            = 0x00000004,
+	 CAP_LARGE_FILES        = 0x00000008,
+	 CAP_NT_SMBS            = 0x00000010,	/* implies CAP_NT_FIND */
+	 CAP_RPC_REMOTE_APIS    = 0x00000020,
+	 CAP_STATUS32           = 0x00000040,
+	 CAP_LEVEL_II_OPLOCKS   = 0x00000080,
+	 CAP_LOCK_AND_READ      = 0x00000100,
+	 CAP_NT_FIND            = 0x00000200,
+	 CAP_DFS                = 0x00001000,
+	 CAP_INFOLEVEL_PASSTHRU = 0x00002000,
+	 CAP_LARGE_READ_X       = 0x00004000,
+	 CAP_LARGE_WRITE_X      = 0x00008000,
+	 CAP_UNIX               = 0x00800000,
+	 CAP_RESERVED           = 0x02000000,
+	 CAP_BULK_TRANSFER      = 0x20000000,
+	 CAP_COMPRESSED_DATA    = 0x40000000,
+	 CAP_EXTENDED_SECURITY  = 0x80000000
+};
 
 typedef union smb_com_session_setup_andx {
 	struct {		/* request format */
@@ -523,16 +554,6 @@
 
 #define CIFS_NETWORK_OPSYS "CIFS VFS Client for Linux"
 
-/* Capabilities bits (for NTLM SessSetup request) */
-#define CAP_UNICODE            0x00000004
-#define CAP_LARGE_FILES        0x00000008
-#define CAP_NT_SMBS            0x00000010
-#define CAP_STATUS32           0x00000040
-#define CAP_LEVEL_II_OPLOCKS   0x00000080
-#define CAP_NT_FIND            0x00000200	/* reserved should be zero (presumably because NT_SMBs implies the same thing) */
-#define CAP_BULK_TRANSFER      0x20000000
-#define CAP_EXTENDED_SECURITY  0x80000000
-
 /* Action bits */
 #define GUEST_LOGIN 1
 
@@ -561,11 +582,16 @@
 } TCONX_RSP;
 
 /* tree connect Flags */
-#define DISCONNECT_TID          0x0001
-#define TCON_EXTENDED_SECINFO   0x0008
+enum {
+	 DISCONNECT_TID          = 0x0001,
+	 TCON_EXTENDED_SECINFO   = 0x0008
+};
+
 /* OptionalSupport bits */
-#define SMB_SUPPORT_SEARCH_BITS 0x0001	/* must have bits (exclusive searches suppt. */
-#define SMB_SHARE_IS_IN_DFS     0x0002
+enum {
+	 SMB_SUPPORT_SEARCH_BITS = 0x0001,	/* must have bits (exclusive searches suppt. */
+	 SMB_SHARE_IS_IN_DFS     = 0x0002
+};
 
 typedef struct smb_com_logoff_andx_req {
 
@@ -614,9 +640,11 @@
 } FINDCLOSE_REQ;
 
 /* OpenFlags */
-#define REQ_OPLOCK         0x00000002
-#define REQ_BATCHOPLOCK    0x00000004
-#define REQ_OPENDIRONLY    0x00000008
+enum {
+	 REQ_OPLOCK         = 0x00000002,
+	 REQ_BATCHOPLOCK    = 0x00000004,
+	 REQ_OPENDIRONLY    = 0x00000008
+};
 
 typedef struct smb_com_open_req {	/* also handles create */
 	struct smb_hdr hdr;	/* wct = 24 */
@@ -640,10 +668,12 @@
 } OPEN_REQ;
 
 /* open response: oplock levels */
-#define OPLOCK_NONE  	 0
-#define OPLOCK_EXCLUSIVE 1
-#define OPLOCK_BATCH	 2
-#define OPLOCK_READ	 3  /* level 2 oplock */
+enum {
+	 OPLOCK_NONE  	  = 0,
+	 OPLOCK_EXCLUSIVE = 1,
+	 OPLOCK_BATCH	  = 2,
+	 OPLOCK_READ	  = 3  /* level 2 oplock */
+};
 
 /* open response for CreateAction shifted left */
 #define CIFS_CREATE_ACTION 0x20000 /* file created */
@@ -740,11 +770,13 @@
 	__le32 LengthLow;
 } LOCKING_ANDX_RANGE;
 
-#define LOCKING_ANDX_SHARED_LOCK     0x01
-#define LOCKING_ANDX_OPLOCK_RELEASE  0x02
-#define LOCKING_ANDX_CHANGE_LOCKTYPE 0x04
-#define LOCKING_ANDX_CANCEL_LOCK     0x08
-#define LOCKING_ANDX_LARGE_FILES     0x10	/* always on for us */
+enum {
+	 LOCKING_ANDX_SHARED_LOCK     = 0x01,
+	 LOCKING_ANDX_OPLOCK_RELEASE  = 0x02,
+	 LOCKING_ANDX_CHANGE_LOCKTYPE = 0x04,
+	 LOCKING_ANDX_CANCEL_LOCK     = 0x08,
+	 LOCKING_ANDX_LARGE_FILES     = 0x10	/* always on for us */
+};
 
 typedef struct smb_com_lock_req {
 	struct smb_hdr hdr;	/* wct = 8 */
@@ -779,13 +811,15 @@
 	/* followed by NewFileName */
 } RENAME_REQ;
 
-	/* copy request flags */
-#define COPY_MUST_BE_FILE      0x0001
-#define COPY_MUST_BE_DIR       0x0002
-#define COPY_TARGET_MODE_ASCII 0x0004 /* if not set, binary */
-#define COPY_SOURCE_MODE_ASCII 0x0008 /* if not set, binary */
-#define COPY_VERIFY_WRITES     0x0010
-#define COPY_TREE              0x0020 
+/* copy request flags */
+enum {
+	 COPY_MUST_BE_FILE      = 0x0001,
+	 COPY_MUST_BE_DIR       = 0x0002,
+	 COPY_TARGET_MODE_ASCII = 0x0004, /* if not set, binary */
+	 COPY_SOURCE_MODE_ASCII = 0x0008, /* if not set, binary */
+	 COPY_VERIFY_WRITES     = 0x0010,
+	 COPY_TREE              = 0x0020 
+};
 
 typedef struct smb_com_copy_req {
 	struct smb_hdr hdr;	/* wct = 3 */
@@ -807,9 +841,11 @@
 	unsigned char ErrorFileName[1]; /* only present if error in copy */
 } COPY_RSP;
 
-#define CREATE_HARD_LINK		0x103
-#define MOVEFILE_COPY_ALLOWED		0x0002
-#define MOVEFILE_REPLACE_EXISTING	0x0001
+enum {
+	 CREATE_HARD_LINK		= 0x103,
+	 MOVEFILE_COPY_ALLOWED		= 0x0002,
+	 MOVEFILE_REPLACE_EXISTING	= 0x0001
+};
 
 typedef struct smb_com_nt_rename_req {	/* A5 - also used for create hardlink */
 	struct smb_hdr hdr;	/* wct = 4 */
@@ -949,29 +985,34 @@
 	__u16 ByteCount;
 	/* __u8 Pad[3]; */
 } TRANSACT_CHANGE_NOTIFY_RSP;
+
 /* Completion Filter flags for Notify */
-#define FILE_NOTIFY_CHANGE_FILE_NAME    0x00000001
-#define FILE_NOTIFY_CHANGE_DIR_NAME     0x00000002
-#define FILE_NOTIFY_CHANGE_NAME         0x00000003
-#define FILE_NOTIFY_CHANGE_ATTRIBUTES   0x00000004
-#define FILE_NOTIFY_CHANGE_SIZE         0x00000008
-#define FILE_NOTIFY_CHANGE_LAST_WRITE   0x00000010
-#define FILE_NOTIFY_CHANGE_LAST_ACCESS  0x00000020
-#define FILE_NOTIFY_CHANGE_CREATION     0x00000040
-#define FILE_NOTIFY_CHANGE_EA           0x00000080
-#define FILE_NOTIFY_CHANGE_SECURITY     0x00000100
-#define FILE_NOTIFY_CHANGE_STREAM_NAME  0x00000200
-#define FILE_NOTIFY_CHANGE_STREAM_SIZE  0x00000400
-#define FILE_NOTIFY_CHANGE_STREAM_WRITE 0x00000800
-
-#define FILE_ACTION_ADDED		0x00000001
-#define FILE_ACTION_REMOVED		0x00000002
-#define FILE_ACTION_MODIFIED		0x00000003
-#define FILE_ACTION_RENAMED_OLD_NAME	0x00000004
-#define FILE_ACTION_RENAMED_NEW_NAME	0x00000005
-#define FILE_ACTION_ADDED_STREAM	0x00000006
-#define FILE_ACTION_REMOVED_STREAM	0x00000007
-#define FILE_ACTION_MODIFIED_STREAM	0x00000008
+enum {
+	 FILE_NOTIFY_CHANGE_FILE_NAME    = 0x00000001,
+	 FILE_NOTIFY_CHANGE_DIR_NAME     = 0x00000002,
+	 FILE_NOTIFY_CHANGE_NAME         = 0x00000003,
+	 FILE_NOTIFY_CHANGE_ATTRIBUTES   = 0x00000004,
+	 FILE_NOTIFY_CHANGE_SIZE         = 0x00000008,
+	 FILE_NOTIFY_CHANGE_LAST_WRITE   = 0x00000010,
+	 FILE_NOTIFY_CHANGE_LAST_ACCESS  = 0x00000020,
+	 FILE_NOTIFY_CHANGE_CREATION     = 0x00000040,
+	 FILE_NOTIFY_CHANGE_EA           = 0x00000080,
+	 FILE_NOTIFY_CHANGE_SECURITY     = 0x00000100,
+	 FILE_NOTIFY_CHANGE_STREAM_NAME  = 0x00000200,
+	 FILE_NOTIFY_CHANGE_STREAM_SIZE  = 0x00000400,
+	 FILE_NOTIFY_CHANGE_STREAM_WRITE = 0x00000800
+};
+
+enum {
+	 FILE_ACTION_ADDED		= 0x00000001,
+	 FILE_ACTION_REMOVED		= 0x00000002,
+	 FILE_ACTION_MODIFIED		= 0x00000003,
+	 FILE_ACTION_RENAMED_OLD_NAME	= 0x00000004,
+	 FILE_ACTION_RENAMED_NEW_NAME	= 0x00000005,
+	 FILE_ACTION_ADDED_STREAM	= 0x00000006,
+	 FILE_ACTION_REMOVED_STREAM	= 0x00000007,
+	 FILE_ACTION_MODIFIED_STREAM	= 0x00000008
+};
 
 /* response contains array of the following structures */
 struct file_notify_information {
@@ -1003,9 +1044,11 @@
 };
 
 /* quota sub commands */
-#define QUOTA_LIST_CONTINUE	    0
-#define QUOTA_LIST_START	0x100
-#define QUOTA_FOR_SID		0x101
+enum {
+	 QUOTA_LIST_CONTINUE	= 0,
+	 QUOTA_LIST_START	= 0x100,
+	 QUOTA_FOR_SID		= 0x101
+};
 
 struct trans2_req {
 	/* struct smb_hdr hdr precedes. Set wct = 14+ */
@@ -1058,61 +1101,66 @@
 };
 
 /* PathInfo/FileInfo infolevels */
-#define SMB_INFO_STANDARD                   1
-#define SMB_SET_FILE_EA                     2
-#define SMB_QUERY_FILE_EA_SIZE              2
-#define SMB_INFO_QUERY_EAS_FROM_LIST        3
-#define SMB_INFO_QUERY_ALL_EAS              4
-#define SMB_INFO_IS_NAME_VALID              6
-#define SMB_QUERY_FILE_BASIC_INFO       0x101
-#define SMB_QUERY_FILE_STANDARD_INFO    0x102
-#define SMB_QUERY_FILE_EA_INFO          0x103
-#define SMB_QUERY_FILE_NAME_INFO        0x104
-#define SMB_QUERY_FILE_ALLOCATION_INFO  0x105
-#define SMB_QUERY_FILE_END_OF_FILEINFO  0x106
-#define SMB_QUERY_FILE_ALL_INFO         0x107
-#define SMB_QUERY_ALT_NAME_INFO         0x108
-#define SMB_QUERY_FILE_STREAM_INFO      0x109
-#define SMB_QUERY_FILE_COMPRESSION_INFO 0x10B
-#define SMB_QUERY_FILE_UNIX_BASIC       0x200
-#define SMB_QUERY_FILE_UNIX_LINK        0x201
-#define SMB_QUERY_POSIX_ACL             0x204
-#define SMB_QUERY_XATTR                 0x205
-#define SMB_QUERY_FILE_INTERNAL_INFO    0x3ee
-#define SMB_QUERY_FILE_ACCESS_INFO      0x3f0
-#define SMB_QUERY_FILE_NAME_INFO2       0x3f1 /* 0x30 bytes */
-#define SMB_QUERY_FILE_POSITION_INFO    0x3f6 
-#define SMB_QUERY_FILE_MODE_INFO        0x3f8
-#define SMB_QUERY_FILE_ALGN_INFO        0x3f9 
-
-
-#define SMB_SET_FILE_BASIC_INFO	        0x101
-#define SMB_SET_FILE_DISPOSITION_INFO   0x102
-#define SMB_SET_FILE_ALLOCATION_INFO    0x103
-#define SMB_SET_FILE_END_OF_FILE_INFO   0x104
-#define SMB_SET_FILE_UNIX_BASIC         0x200
-#define SMB_SET_FILE_UNIX_LINK          0x201
-#define SMB_SET_FILE_UNIX_HLINK         0x203
-#define SMB_SET_POSIX_ACL               0x204
-#define SMB_SET_XATTR                   0x205
-#define SMB_SET_FILE_BASIC_INFO2        0x3ec
-#define SMB_SET_FILE_RENAME_INFORMATION 0x3f2 /* BB check if qpathinfo level too */
-#define SMB_FILE_ALL_INFO2              0x3fa
-#define SMB_SET_FILE_ALLOCATION_INFO2   0x3fb
-#define SMB_SET_FILE_END_OF_FILE_INFO2  0x3fc
-#define SMB_FILE_MOVE_CLUSTER_INFO      0x407
-#define SMB_FILE_QUOTA_INFO             0x408
-#define SMB_FILE_REPARSEPOINT_INFO      0x409
-#define SMB_FILE_MAXIMUM_INFO           0x40d
+enum {
+	 SMB_INFO_STANDARD               = 1,
+	 SMB_SET_FILE_EA                 = 2,
+	 SMB_QUERY_FILE_EA_SIZE          = 2,
+	 SMB_INFO_QUERY_EAS_FROM_LIST    = 3,
+	 SMB_INFO_QUERY_ALL_EAS          = 4,
+	 SMB_INFO_IS_NAME_VALID          = 6,
+	 SMB_QUERY_FILE_BASIC_INFO       = 0x101,
+	 SMB_QUERY_FILE_STANDARD_INFO    = 0x102,
+	 SMB_QUERY_FILE_EA_INFO          = 0x103,
+	 SMB_QUERY_FILE_NAME_INFO        = 0x104,
+	 SMB_QUERY_FILE_ALLOCATION_INFO  = 0x105,
+	 SMB_QUERY_FILE_END_OF_FILEINFO  = 0x106,
+	 SMB_QUERY_FILE_ALL_INFO         = 0x107,
+	 SMB_QUERY_ALT_NAME_INFO         = 0x108,
+	 SMB_QUERY_FILE_STREAM_INFO      = 0x109,
+	 SMB_QUERY_FILE_COMPRESSION_INFO = 0x10B,
+	 SMB_QUERY_FILE_UNIX_BASIC       = 0x200,
+	 SMB_QUERY_FILE_UNIX_LINK        = 0x201,
+	 SMB_QUERY_POSIX_ACL             = 0x204,
+	 SMB_QUERY_XATTR                 = 0x205,
+	 SMB_QUERY_FILE_INTERNAL_INFO    = 0x3ee,
+	 SMB_QUERY_FILE_ACCESS_INFO      = 0x3f0,
+	 SMB_QUERY_FILE_NAME_INFO2       = 0x3f1, /* = 0x30 bytes */
+	 SMB_QUERY_FILE_POSITION_INFO    = 0x3f6,
+	 SMB_QUERY_FILE_MODE_INFO        = 0x3f8,
+	 SMB_QUERY_FILE_ALGN_INFO        = 0x3f9 
+};
+
+enum {
+	 SMB_SET_FILE_BASIC_INFO	 = 0x101,
+	 SMB_SET_FILE_DISPOSITION_INFO   = 0x102,
+	 SMB_SET_FILE_ALLOCATION_INFO    = 0x103,
+	 SMB_SET_FILE_END_OF_FILE_INFO   = 0x104,
+	 SMB_SET_FILE_UNIX_BASIC         = 0x200,
+	 SMB_SET_FILE_UNIX_LINK          = 0x201,
+	 SMB_SET_FILE_UNIX_HLINK         = 0x203,
+	 SMB_SET_POSIX_ACL               = 0x204,
+	 SMB_SET_XATTR                   = 0x205,
+	 SMB_SET_FILE_BASIC_INFO2        = 0x3ec,
+	 SMB_SET_FILE_RENAME_INFORMATION = 0x3f2, /* BB check if qpathinfo level too */
+	 SMB_FILE_ALL_INFO2              = 0x3fa,
+	 SMB_SET_FILE_ALLOCATION_INFO2   = 0x3fb,
+	 SMB_SET_FILE_END_OF_FILE_INFO2  = 0x3fc,
+	 SMB_FILE_MOVE_CLUSTER_INFO      = 0x407,
+	 SMB_FILE_QUOTA_INFO             = 0x408,
+	 SMB_FILE_REPARSEPOINT_INFO      = 0x409,
+	 SMB_FILE_MAXIMUM_INFO           = 0x40d
+};
 
 /* Find File infolevels */
-#define SMB_FIND_FILE_DIRECTORY_INFO      0x101
-#define SMB_FIND_FILE_FULL_DIRECTORY_INFO 0x102
-#define SMB_FIND_FILE_NAMES_INFO          0x103
-#define SMB_FIND_FILE_BOTH_DIRECTORY_INFO 0x104
-#define SMB_FIND_FILE_ID_FULL_DIR_INFO    0x105
-#define SMB_FIND_FILE_ID_BOTH_DIR_INFO    0x106
-#define SMB_FIND_FILE_UNIX                0x202
+enum {
+	 SMB_FIND_FILE_DIRECTORY_INFO      = 0x101,
+	 SMB_FIND_FILE_FULL_DIRECTORY_INFO = 0x102,
+	 SMB_FIND_FILE_NAMES_INFO          = 0x103,
+	 SMB_FIND_FILE_BOTH_DIRECTORY_INFO = 0x104,
+	 SMB_FIND_FILE_ID_FULL_DIR_INFO    = 0x105,
+	 SMB_FIND_FILE_ID_BOTH_DIR_INFO    = 0x106,
+	 SMB_FIND_FILE_UNIX                = 0x202
+};
 
 typedef struct smb_com_transaction2_qpi_req {
 	struct smb_hdr hdr;	/* wct = 14+ */
@@ -1223,11 +1271,13 @@
 /*
  * Flags on T2 FINDFIRST and FINDNEXT 
  */
-#define CIFS_SEARCH_CLOSE_ALWAYS  0x0001
-#define CIFS_SEARCH_CLOSE_AT_END  0x0002
-#define CIFS_SEARCH_RETURN_RESUME 0x0004
-#define CIFS_SEARCH_CONTINUE_FROM_LAST 0x0008
-#define CIFS_SEARCH_BACKUP_SEARCH 0x0010
+enum {
+	 CIFS_SEARCH_CLOSE_ALWAYS  = 0x0001,
+	 CIFS_SEARCH_CLOSE_AT_END  = 0x0002,
+	 CIFS_SEARCH_RETURN_RESUME = 0x0004,
+	 CIFS_SEARCH_CONTINUE_FROM_LAST = 0x0008,
+	 CIFS_SEARCH_BACKUP_SEARCH = 0x0010
+};
 
 /*
  * Size of the resume key on FINDFIRST and FINDNEXT calls
@@ -1318,17 +1368,19 @@
 } T2_FNEXT_RSP_PARMS;
 
 /* QFSInfo Levels */
-#define SMB_INFO_ALLOCATION         1
-#define SMB_INFO_VOLUME             2
-#define SMB_QUERY_FS_VOLUME_INFO    0x102
-#define SMB_QUERY_FS_SIZE_INFO      0x103
-#define SMB_QUERY_FS_DEVICE_INFO    0x104
-#define SMB_QUERY_FS_ATTRIBUTE_INFO 0x105
-#define SMB_QUERY_CIFS_UNIX_INFO    0x200
-#define SMB_QUERY_LABEL_INFO        0x3ea
-#define SMB_QUERY_FS_QUOTA_INFO     0x3ee
-#define SMB_QUERY_FS_FULL_SIZE_INFO 0x3ef
-#define SMB_QUERY_OBJECTID_INFO     0x3f0
+enum {
+	 SMB_INFO_ALLOCATION         = 1,
+	 SMB_INFO_VOLUME             = 2,
+	 SMB_QUERY_FS_VOLUME_INFO    = 0x102,
+	 SMB_QUERY_FS_SIZE_INFO      = 0x103,
+	 SMB_QUERY_FS_DEVICE_INFO    = 0x104,
+	 SMB_QUERY_FS_ATTRIBUTE_INFO = 0x105,
+	 SMB_QUERY_CIFS_UNIX_INFO    = 0x200,
+	 SMB_QUERY_LABEL_INFO        = 0x3ea,
+	 SMB_QUERY_FS_QUOTA_INFO     = 0x3ee,
+	 SMB_QUERY_FS_FULL_SIZE_INFO = 0x3ef,
+	 SMB_QUERY_OBJECTID_INFO     = 0x3f0
+};
 
 typedef struct smb_com_transaction2_qfsi_req {
 	struct smb_hdr hdr;	/* wct = 14+ */
@@ -1410,8 +1462,10 @@
 } TRANSACTION2_GET_DFS_REFER_RSP;
 
 /* DFS Flags */
-#define DFSREF_REFERRAL_SERVER  0x0001
-#define DFSREF_STORAGE_SERVER   0x0002
+enum {
+	 DFSREF_REFERRAL_SERVER  = 0x0001,
+	 DFSREF_STORAGE_SERVER   = 0x0002
+};
 
 /* IOCTL information */
 /* List of ioctl function codes that look to be of interest to remote clients like this. */
@@ -1419,30 +1473,34 @@
 /* Some of the following such as the encryption/compression ones would be                */
 /* invoked from tools via a specialized hook into the VFS rather than via the            */
 /* standard vfs entry points */
-#define FSCTL_REQUEST_OPLOCK_LEVEL_1 0x00090000
-#define FSCTL_REQUEST_OPLOCK_LEVEL_2 0x00090004
-#define FSCTL_REQUEST_BATCH_OPLOCK   0x00090008
-#define FSCTL_LOCK_VOLUME            0x00090018
-#define FSCTL_UNLOCK_VOLUME          0x0009001C
-#define FSCTL_GET_COMPRESSION        0x0009003C
-#define FSCTL_SET_COMPRESSION        0x0009C040
-#define FSCTL_REQUEST_FILTER_OPLOCK  0x0009008C
-#define FSCTL_FILESYS_GET_STATISTICS 0x00090090
-#define FSCTL_SET_REPARSE_POINT      0x000900A4
-#define FSCTL_GET_REPARSE_POINT      0x000900A8
-#define FSCTL_DELETE_REPARSE_POINT   0x000900AC
-#define FSCTL_SET_SPARSE             0x000900C4
-#define FSCTL_SET_ZERO_DATA          0x000900C8
-#define FSCTL_SET_ENCRYPTION         0x000900D7
-#define FSCTL_ENCRYPTION_FSCTL_IO    0x000900DB
-#define FSCTL_WRITE_RAW_ENCRYPTED    0x000900DF
-#define FSCTL_READ_RAW_ENCRYPTED     0x000900E3
-#define FSCTL_SIS_COPYFILE           0x00090100
-#define FSCTL_SIS_LINK_FILES         0x0009C104
-
-#define IO_REPARSE_TAG_MOUNT_POINT   0xA0000003
-#define IO_REPARSE_TAG_HSM           0xC0000004
-#define IO_REPARSE_TAG_SIS           0x80000007
+enum {
+	 FSCTL_REQUEST_OPLOCK_LEVEL_1 = 0x00090000,
+	 FSCTL_REQUEST_OPLOCK_LEVEL_2 = 0x00090004,
+	 FSCTL_REQUEST_BATCH_OPLOCK   = 0x00090008,
+	 FSCTL_LOCK_VOLUME            = 0x00090018,
+	 FSCTL_UNLOCK_VOLUME          = 0x0009001C,
+	 FSCTL_GET_COMPRESSION        = 0x0009003C,
+	 FSCTL_SET_COMPRESSION        = 0x0009C040,
+	 FSCTL_REQUEST_FILTER_OPLOCK  = 0x0009008C,
+	 FSCTL_FILESYS_GET_STATISTICS = 0x00090090,
+	 FSCTL_SET_REPARSE_POINT      = 0x000900A4,
+	 FSCTL_GET_REPARSE_POINT      = 0x000900A8,
+	 FSCTL_DELETE_REPARSE_POINT   = 0x000900AC,
+	 FSCTL_SET_SPARSE             = 0x000900C4,
+	 FSCTL_SET_ZERO_DATA          = 0x000900C8,
+	 FSCTL_SET_ENCRYPTION         = 0x000900D7,
+	 FSCTL_ENCRYPTION_FSCTL_IO    = 0x000900DB,
+	 FSCTL_WRITE_RAW_ENCRYPTED    = 0x000900DF,
+	 FSCTL_READ_RAW_ENCRYPTED     = 0x000900E3,
+	 FSCTL_SIS_COPYFILE           = 0x00090100,
+	 FSCTL_SIS_LINK_FILES         = 0x0009C104
+};
+
+enum {
+	 IO_REPARSE_TAG_MOUNT_POINT   = 0xA0000003,
+	 IO_REPARSE_TAG_HSM           = 0xC0000004,
+	 IO_REPARSE_TAG_SIS           = 0x80000007
+};
 
 /*
  ************************************************************************
@@ -1501,29 +1559,33 @@
 	__le64 Capability;
 } FILE_SYSTEM_UNIX_INFO;	/* Unix extensions info, level 0x200 */
 /* Linux/Unix extensions capability flags */
-#define CIFS_UNIX_FCNTL_CAP             0x00000001 /* support for fcntl locks */
-#define CIFS_UNIX_POSIX_ACL_CAP         0x00000002
-#define CIFS_UNIX_XATTR_CAP             0x00000004 /*support for new namespace*/
+enum {
+	 CIFS_UNIX_FCNTL_CAP             = 0x00000001, /* support for fcntl locks */
+	 CIFS_UNIX_POSIX_ACL_CAP         = 0x00000002,
+	 CIFS_UNIX_XATTR_CAP             = 0x00000004 /*support for new namespace*/
+};
 
 /* DeviceType Flags */
-#define FILE_DEVICE_CD_ROM              0x00000002
-#define FILE_DEVICE_CD_ROM_FILE_SYSTEM  0x00000003
-#define FILE_DEVICE_DFS                 0x00000006
-#define FILE_DEVICE_DISK                0x00000007
-#define FILE_DEVICE_DISK_FILE_SYSTEM    0x00000008
-#define FILE_DEVICE_FILE_SYSTEM         0x00000009
-#define FILE_DEVICE_NAMED_PIPE          0x00000011
-#define FILE_DEVICE_NETWORK             0x00000012
-#define FILE_DEVICE_NETWORK_FILE_SYSTEM 0x00000014
-#define FILE_DEVICE_NULL                0x00000015
-#define FILE_DEVICE_PARALLEL_PORT       0x00000016
-#define FILE_DEVICE_PRINTER             0x00000018
-#define FILE_DEVICE_SERIAL_PORT         0x0000001b
-#define FILE_DEVICE_STREAMS             0x0000001e
-#define FILE_DEVICE_TAPE                0x0000001f
-#define FILE_DEVICE_TAPE_FILE_SYSTEM    0x00000020
-#define FILE_DEVICE_VIRTUAL_DISK        0x00000024
-#define FILE_DEVICE_NETWORK_REDIRECTOR  0x00000028
+enum {
+	 FILE_DEVICE_CD_ROM              = 0x00000002,
+	 FILE_DEVICE_CD_ROM_FILE_SYSTEM  = 0x00000003,
+	 FILE_DEVICE_DFS                 = 0x00000006,
+	 FILE_DEVICE_DISK                = 0x00000007,
+	 FILE_DEVICE_DISK_FILE_SYSTEM    = 0x00000008,
+	 FILE_DEVICE_FILE_SYSTEM         = 0x00000009,
+	 FILE_DEVICE_NAMED_PIPE          = 0x00000011,
+	 FILE_DEVICE_NETWORK             = 0x00000012,
+	 FILE_DEVICE_NETWORK_FILE_SYSTEM = 0x00000014,
+	 FILE_DEVICE_NULL                = 0x00000015,
+	 FILE_DEVICE_PARALLEL_PORT       = 0x00000016,
+	 FILE_DEVICE_PRINTER             = 0x00000018,
+	 FILE_DEVICE_SERIAL_PORT         = 0x0000001b,
+	 FILE_DEVICE_STREAMS             = 0x0000001e,
+	 FILE_DEVICE_TAPE                = 0x0000001f,
+	 FILE_DEVICE_TAPE_FILE_SYSTEM    = 0x00000020,
+	 FILE_DEVICE_VIRTUAL_DISK        = 0x00000024,
+	 FILE_DEVICE_NETWORK_REDIRECTOR  = 0x00000028
+};
 
 typedef struct {
 	__le32 DeviceType;
@@ -1565,13 +1627,16 @@
 } FILE_ALL_INFO;		/* level 0x107 QPathInfo */
 
 /* defines for enumerating possible values of the Unix type field below */
-#define UNIX_FILE      0
-#define UNIX_DIR       1
-#define UNIX_SYMLINK   2
-#define UNIX_CHARDEV   3
-#define UNIX_BLOCKDEV  4
-#define UNIX_FIFO      5
-#define UNIX_SOCKET    6
+enum {
+	 UNIX_FILE      = 0,
+	 UNIX_DIR       = 1,
+	 UNIX_SYMLINK   = 2,
+	 UNIX_CHARDEV   = 3,
+	 UNIX_BLOCKDEV  = 4,
+	 UNIX_FIFO      = 5,
+	 UNIX_SOCKET    = 6
+};
+
 typedef struct {
 	__le64 EndOfFile;
 	__le64 NumOfBytes;
@@ -1660,21 +1725,6 @@
 	struct cifs_posix_ace default_ace_arraay[] */
 };  /* level 0x204 */
 
-/* types of access control entries already defined in posix_acl.h */
-/* #define CIFS_POSIX_ACL_USER_OBJ	 0x01
-#define CIFS_POSIX_ACL_USER      0x02
-#define CIFS_POSIX_ACL_GROUP_OBJ 0x04
-#define CIFS_POSIX_ACL_GROUP     0x08
-#define CIFS_POSIX_ACL_MASK      0x10
-#define CIFS_POSIX_ACL_OTHER     0x20 */
-
-/* types of perms */
-/* #define CIFS_POSIX_ACL_EXECUTE   0x01
-#define CIFS_POSIX_ACL_WRITE     0x02
-#define CIFS_POSIX_ACL_READ	     0x04 */
-
-/* end of POSIX ACL definitions */
-
 struct file_internal_info {
 	__u64  UniqueId; /* inode number */
 };      /* level 0x3ee */


