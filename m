Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264967AbSKETad>; Tue, 5 Nov 2002 14:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbSKETac>; Tue, 5 Nov 2002 14:30:32 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:22983 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264967AbSKETac>; Tue, 5 Nov 2002 14:30:32 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 6 Nov 2002 06:36:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15816.7642.109406.151180@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Reconfiguring one SW-RAID when other RAIDs are running
In-Reply-To: message from H. Peter Anvin on Monday November 4
References: <3DC762FC.8070007@zytor.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 4, hpa@zytor.com wrote:
> Hi all,
> 
> I'm trying to re-create a RAID while leaving the other RAIDs -- 
> including the root filesystem -- running, but mkraid refuses to run:
> 
> hera 1 # mkraid /dev/md2
> /dev/md0: array is active -- run raidstop first.
> mkraid: aborted.
> (In addition to the above messages, see the syslog and /proc/mdstat as well
>   for potential clues.)

My guess is that the following patch would fix it, but I haven't
tested it.

NeilBrown

--- mkraid.c	2002/11/05 19:34:57	1.1
+++ mkraid.c	2002/11/05 19:35:29
@@ -244,7 +244,7 @@ int main (int argc, char *argv[])
     while (*args) {
 	for (p = cfg_head; p; p = p->next) {
 	    if (strcmp(p->md_name, *args)) continue;
-	    if (check_active(cfg)) 
+	    if (check_active(p)) 
 		goto abort;
 	    if (force_flag) {
 		fprintf(stderr, "DESTROYING the contents of %s in 5 seconds, Ctrl-C if unsure!\n", *args);

