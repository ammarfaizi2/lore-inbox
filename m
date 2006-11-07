Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753848AbWKGXCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbWKGXCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbWKGXCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:02:06 -0500
Received: from lug-owl.de ([195.71.106.12]:39915 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1753848AbWKGXCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:02:03 -0500
Date: Wed, 8 Nov 2006 00:02:01 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: eki@sci.fi, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Missing *eof assignment in Alpha's srm_env driver
Message-ID: <20061107230201.GY21485@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>, eki@sci.fi,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PxDrs/Fpf4pPiewX"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PxDrs/Fpf4pPiewX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please pull from
git://git.kernel.org/pub/scm/linux/kernel/git/jbglaw/vax-linux.git ,
branch `upstream-linus'. Despite the repo's name, it contains a fix
for the srm_env driver on Alpha:

 arch/alpha/kernel/srm_env.c |   84 ++++++++++++++-------------------------=
----
 1 files changed, 27 insertions(+), 57 deletions(-)

commit 16b7f4dcd340875625714438a812ea06400f9666
Author: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date:   Tue Nov 7 23:50:37 2006 +0100

    Update for the srm_env driver.
   =20
    This patch contains a fix for a bug introduced more than a year ago
    (not setting *eof) and updates whitespace a bit.
   =20
    Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>



--- a/arch/alpha/kernel/srm_env.c
+++ b/arch/alpha/kernel/srm_env.c
@@ -2,7 +2,7 @@
  * srm_env.c - Access to SRM environment
  *             variables through linux' procfs
  *
- * Copyright (C) 2001-2002 Jan-Benedict Glaw <jbglaw@lug-owl.de>
+ * (C) 2001,2002,2006 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
  *
  * This driver is at all a modified version of Erik Mouw's
  * Documentation/DocBook/procfs_example.c, so: thank
@@ -21,7 +21,7 @@
  * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  * PURPOSE.  See the GNU General Public License for more
  * details.
- *=20
+ *
  * You should have received a copy of the GNU General Public
  * License along with this program; if not, write to the
  * Free Software Foundation, Inc., 59 Temple Place,
@@ -29,33 +29,6 @@
  *
  */
=20
-/*
- * Changelog
- * ~~~~~~~~~
- *
- * Thu, 22 Aug 2002 15:10:43 +0200
- * 	- Update Config.help entry. I got a number of emails asking
- * 	  me to tell their senders if they could make use of this
- * 	  piece of code... So: "SRM is something like BIOS for your
- * 	  Alpha"
- * 	- Update code formatting a bit to better conform CodingStyle
- * 	  rules.
- * 	- So this is v0.0.5, with no changes (except formatting)
- * =09
- * Wed, 22 May 2002 00:11:21 +0200
- * 	- Fix typo on comment (SRC -> SRM)
- * 	- Call this "Version 0.0.4"
- *
- * Tue,  9 Apr 2002 18:44:40 +0200
- * 	- Implement access by variable name and additionally
- * 	  by number. This is done by creating two subdirectories
- * 	  where one holds all names (like the old directory
- * 	  did) and the other holding 256 files named like "0",
- * 	  "1" and so on.
- * 	- Call this "Version 0.0.3"
- *
- */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -67,7 +40,7 @@ #include <asm/machvec.h>
 #define BASE_DIR	"srm_environment"	/* Subdir in /proc/		*/
 #define NAMED_DIR	"named_variables"	/* Subdir for known variables	*/
 #define NUMBERED_DIR	"numbered_variables"	/* Subdir for all variables	*/
-#define VERSION		"0.0.5"			/* Module version		*/
+#define VERSION		"0.0.6"			/* Module version		*/
 #define NAME		"srm_env"		/* Module name			*/
=20
 MODULE_AUTHOR("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
@@ -106,7 +79,6 @@ static srm_env_t	srm_named_entries[] =3D {
 static srm_env_t	srm_numbered_entries[256];
=20
=20
-
 static int
 srm_env_read(char *page, char **start, off_t off, int count, int *eof,
 		void *data)
@@ -115,21 +87,23 @@ srm_env_read(char *page, char **start, o
 	unsigned long	ret;
 	srm_env_t	*entry;
=20
-	if(off !=3D 0)
-		return -EFAULT;
+	if (off !=3D 0) {
+		*eof =3D 1;
+		return 0;
+	}
=20
 	entry	=3D (srm_env_t *) data;
 	ret	=3D callback_getenv(entry->id, page, count);
=20
-	if((ret >> 61) =3D=3D 0)
+	if ((ret >> 61) =3D=3D 0) {
 		nbytes =3D (int) ret;
-	else
+		*eof =3D 1;
+	} else
 		nbytes =3D -EFAULT;
=20
 	return nbytes;
 }
=20
-
 static int
 srm_env_write(struct file *file, const char __user *buffer, unsigned long =
count,
 		void *data)
@@ -155,7 +129,7 @@ srm_env_write(struct file *file, const c
=20
 	ret1 =3D callback_setenv(entry->id, buf, count);
 	if ((ret1 >> 61) =3D=3D 0) {
-		do=20
+		do
 			ret2 =3D callback_save_env();
 		while((ret2 >> 61) =3D=3D 1);
 		res =3D (int) ret1;
@@ -172,14 +146,14 @@ srm_env_cleanup(void)
 	srm_env_t	*entry;
 	unsigned long	var_num;
=20
-	if(base_dir) {
+	if (base_dir) {
 		/*
 		 * Remove named entries
 		 */
-		if(named_dir) {
+		if (named_dir) {
 			entry =3D srm_named_entries;
-			while(entry->name !=3D NULL && entry->id !=3D 0) {
-				if(entry->proc_entry) {
+			while (entry->name !=3D NULL && entry->id !=3D 0) {
+				if (entry->proc_entry) {
 					remove_proc_entry(entry->name,
 							named_dir);
 					entry->proc_entry =3D NULL;
@@ -192,11 +166,11 @@ srm_env_cleanup(void)
 		/*
 		 * Remove numbered entries
 		 */
-		if(numbered_dir) {
-			for(var_num =3D 0; var_num <=3D 255; var_num++) {
+		if (numbered_dir) {
+			for (var_num =3D 0; var_num <=3D 255; var_num++) {
 				entry =3D	&srm_numbered_entries[var_num];
=20
-				if(entry->proc_entry) {
+				if (entry->proc_entry) {
 					remove_proc_entry(entry->name,
 							numbered_dir);
 					entry->proc_entry	=3D NULL;
@@ -212,7 +186,6 @@ srm_env_cleanup(void)
 	return;
 }
=20
-
 static int __init
 srm_env_init(void)
 {
@@ -222,7 +195,7 @@ srm_env_init(void)
 	/*
 	 * Check system
 	 */
-	if(!alpha_using_srm) {
+	if (!alpha_using_srm) {
 		printk(KERN_INFO "%s: This Alpha system doesn't "
 				"know about SRM (or you've booted "
 				"SRM->MILO->Linux, which gets "
@@ -233,14 +206,14 @@ srm_env_init(void)
 	/*
 	 * Init numbers
 	 */
-	for(var_num =3D 0; var_num <=3D 255; var_num++)
+	for (var_num =3D 0; var_num <=3D 255; var_num++)
 		sprintf(number[var_num], "%ld", var_num);
=20
 	/*
 	 * Create base directory
 	 */
 	base_dir =3D proc_mkdir(BASE_DIR, NULL);
-	if(base_dir =3D=3D NULL) {
+	if (!base_dir) {
 		printk(KERN_ERR "Couldn't create base dir /proc/%s\n",
 				BASE_DIR);
 		goto cleanup;
@@ -251,7 +224,7 @@ srm_env_init(void)
 	 * Create per-name subdirectory
 	 */
 	named_dir =3D proc_mkdir(NAMED_DIR, base_dir);
-	if(named_dir =3D=3D NULL) {
+	if (!named_dir) {
 		printk(KERN_ERR "Couldn't create dir /proc/%s/%s\n",
 				BASE_DIR, NAMED_DIR);
 		goto cleanup;
@@ -262,7 +235,7 @@ srm_env_init(void)
 	 * Create per-number subdirectory
 	 */
 	numbered_dir =3D proc_mkdir(NUMBERED_DIR, base_dir);
-	if(numbered_dir =3D=3D NULL) {
+	if (!numbered_dir) {
 		printk(KERN_ERR "Couldn't create dir /proc/%s/%s\n",
 				BASE_DIR, NUMBERED_DIR);
 		goto cleanup;
@@ -274,10 +247,10 @@ srm_env_init(void)
 	 * Create all named nodes
 	 */
 	entry =3D srm_named_entries;
-	while(entry->name !=3D NULL && entry->id !=3D 0) {
+	while (entry->name && entry->id) {
 		entry->proc_entry =3D create_proc_entry(entry->name,
 				0644, named_dir);
-		if(entry->proc_entry =3D=3D NULL)
+		if (!entry->proc_entry)
 			goto cleanup;
=20
 		entry->proc_entry->data		=3D (void *) entry;
@@ -291,13 +264,13 @@ srm_env_init(void)
 	/*
 	 * Create all numbered nodes
 	 */
-	for(var_num =3D 0; var_num <=3D 255; var_num++) {
+	for (var_num =3D 0; var_num <=3D 255; var_num++) {
 		entry =3D &srm_numbered_entries[var_num];
 		entry->name =3D number[var_num];
=20
 		entry->proc_entry =3D create_proc_entry(entry->name,
 				0644, numbered_dir);
-		if(entry->proc_entry =3D=3D NULL)
+		if (!entry->proc_entry)
 			goto cleanup;
=20
 		entry->id			=3D var_num;
@@ -318,7 +291,6 @@ cleanup:
 	return -ENOMEM;
 }
=20
-
 static void __exit
 srm_env_exit(void)
 {
@@ -328,7 +300,5 @@ srm_env_exit(void)
 	return;
 }
=20
-
 module_init(srm_env_init);
 module_exit(srm_env_exit);
-
--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                 Gib Dein Bestes. Dann =C3=BCbertriff Dich sel=
bst!
the second  :


--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:               http://www.eyrie.org/~eagle/faqs/questions.html
the second  :

--PxDrs/Fpf4pPiewX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFURBpHb1edYOZ4bsRAuPGAJ9AuY5OEhKe+KEwI4MitzwvJv57xQCfQVA9
8g0FqE5pSQ+lMaVzWgoY7do=
=v87x
-----END PGP SIGNATURE-----

--PxDrs/Fpf4pPiewX--
