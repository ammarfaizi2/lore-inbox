Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbREPCqL>; Tue, 15 May 2001 22:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261775AbREPCpv>; Tue, 15 May 2001 22:45:51 -0400
Received: from dsl-64-192-96-25.telocity.com ([64.192.96.25]:20860 "EHLO
	orr.falooley.org") by vger.kernel.org with ESMTP id <S261774AbREPCpr>;
	Tue, 15 May 2001 22:45:47 -0400
Date: Tue, 15 May 2001 22:45:25 -0400
From: Jason Lunz <j@falooley.org>
To: linux-kernel@vger.kernel.org
Subject: DVD_AUTH ioctl fails with aic7xxx / 2.4.4
Message-ID: <20010515224525.A9171@orr.falooley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've set up a Pioneer 305S scsi dvd-rom on an old adaptec card using the
stock aic7xxx driver included with the 2.4.4 kernel (not the old_aic7xxx
one). Everything works well, except when trying to access an encrypted
file on a DVD. This ioctl from libcss fails:

static int _get_title_key(int fd, int agid, int lba, char *key, char *key_title)
{
	dvd_authinfo ai;
	int i;

	ai.type = DVD_LU_SEND_TITLE_KEY;

	ai.lstk.agid = agid;
	ai.lstk.lba = lba;

	if (ioctl (fd, DVD_AUTH, &ai)) {
		perror ("GetTitleKey failed");
		return -1;
	}

All I see from the kernel is:

	sr1: CDROM (ioctl) reports ILLEGAL REQUEST.

This happens with any DVD. Can someone tell me what the problem is? I
seem to be using the same libcss that everyone else uses with no
problem, and everything is properly configured, AFAIK.

thanks,

Jason
