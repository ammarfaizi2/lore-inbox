Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLLCYQ>; Mon, 11 Dec 2000 21:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLLCYK>; Mon, 11 Dec 2000 21:24:10 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:5661 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129228AbQLLCXo>; Mon, 11 Dec 2000 21:23:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14901.34060.536976.829050@somanetworks.com>
Date: Mon, 11 Dec 2000 20:53:16 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: georgn@somanetworks.com, linux-kernel@vger.kernel.org,
        greg@wind.enjellic.com, sct@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: <3586.976584600@kao2.melbourne.sgi.com>
In-Reply-To: <14901.31690.961664.201896@somanetworks.com>
	<3586.976584600@kao2.melbourne.sgi.com>
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "KO" == Keith Owens <kaos@ocs.com.au> writes:

 KO> Looks good, except that you need to keep the option flags for
 KO> backwards compatibility.  There are a *lot* of scripts out there
 KO> which invoke klogd with various options and they will fail with
 KO> this change.  It is OK to issue a warning message "klogd options
 KO> -[iIpkx] are no longer supported" as long as klogd continues to
 KO> run.  Otherwise you will get a lot of irate users complaining
 KO> that klogd is failing at boot time.

You're right.  Here's YAP:

diff -Nru a/src/sysklogd-1.3-31/klogd.c b/src/sysklogd-1.3-31/klogd.c
--- a/src/sysklogd-1.3-31/klogd.c	Mon Dec 11 20:50:49 2000
+++ b/src/sysklogd-1.3-31/klogd.c	Mon Dec 11 20:50:49 2000
@@ -763,7 +763,7 @@
 	chdir ("/");
 #endif
 	/* Parse the command-line. */
-	while ((ch = getopt(argc, argv, "c:df:nosv")) != EOF)
+	while ((ch = getopt(argc, argv, "c:df:nosviIk:px")) != EOF)
 		switch((char)ch)
 		{
 		    case 'c':		/* Set console message level. */
@@ -788,6 +788,20 @@
 		    case 'v':
 			printf("klogd %s-%s\n", VERSION, PATCHLEVEL);
 			exit (1);
+
+		    /* Obsolete options */
+		    case 'i':
+			/* FALLTHRU */
+		    case 'I':
+			/* FALLTHRU */
+		    case 'k':
+			/* FALLTHRU */
+		    case 'p':
+			/* FALLTHRU */
+		    case 'x':
+			fprintf(stderr,
+				"klogd: %c option is obsolete.  Ignoring\n", ch);
+			break;
 		}
 
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
