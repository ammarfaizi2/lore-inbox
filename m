Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbQKMK5k>; Mon, 13 Nov 2000 05:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQKMK5U>; Mon, 13 Nov 2000 05:57:20 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:65040 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129385AbQKMK5P>;
	Mon, 13 Nov 2000 05:57:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Local root exploit with kmod and modutils > 2.1.121
Date: Mon, 13 Nov 2000 21:57:08 +1100
Message-ID: <2329.974113028@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

A local root exploit has been found using kernels compiled with kmod
and modutils > 2.1.121.  Kernels without kmod and systems using
modutils 2.1.121 are not affected.

Patch against modutils 2.3.19, it should fit any 2.3 modutils.

Index: 19.7/util/meta_expand.c
- --- 19.7/util/meta_expand.c Sun, 10 Sep 2000 12:56:40 +1100 kaos (modutils-2.3/10_meta_expan 1.4 644)
+++ 19.7(w)/util/meta_expand.c Mon, 13 Nov 2000 21:19:41 +1100 kaos (modutils-2.3/10_meta_expan 1.4 644)
@@ -156,12 +156,8 @@ static int glob_it(char *pt, GLOB_LIST *
  */
 int meta_expand(char *pt, GLOB_LIST *g, char *base_dir, char *version)
 {
- -	FILE *fin;
- -	int len = 0;
- -	char *line = NULL;
 	char *p;
 	char tmpline[PATH_MAX + 1];
- -	char tmpcmd[PATH_MAX + 11];
 
 	g->pathc = 0;
 	g->pathv = NULL;
@@ -277,38 +273,6 @@ int meta_expand(char *pt, GLOB_LIST *g, 
 		/* Only "=" remaining, should be module options */
 		split_line(g, pt, 0);
 		return 0;
- -	}
- -
- -	/*
- -	 * Last resort: Use "echo"
- -	 */
- -	sprintf(tmpline, "%s%s", (base_dir ? base_dir : ""), pt);
- -	sprintf(tmpcmd, "/bin/echo %s", tmpline);
- -	if ((fin = popen(tmpcmd, "r")) == NULL) {
- -		error("Can't execute: %s", tmpcmd);
- -		return -1;
- -	}
- -	/* else */
- -
- -	/*
- -	 * Collect the result
- -	 */
- -	while (fgets(tmpcmd, PATH_MAX, fin) != NULL) {
- -		int l = strlen(tmpcmd);
- -
- -		line = (char *)xrealloc(line, len + l + 1);
- -		line[len] = '\0';
- -		strcat(line + len, tmpcmd);
- -		len += l;
- -	}
- -	pclose(fin);
- -
- -	if (line) {
- -		/* Ignore result if no expansion occurred */
- -		strcat(tmpline, "\n");
- -		if (strcmp(tmpline, line))
- -			split_line(g, line, 0);
- -		free(line);
 	}
 
 	return 0;

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6D8kEi4UHNye0ZOoRAmVTAKCktbi9DI5t0sj8wd1/vjLtgwVW6QCgnO0L
mVbPskoIGSSyTE8I9K7FcAg=
=Z1/L
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
