Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280660AbRK1UYK>; Wed, 28 Nov 2001 15:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280628AbRK1UYA>; Wed, 28 Nov 2001 15:24:00 -0500
Received: from mailg.telia.com ([194.22.194.26]:59615 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S280664AbRK1UXo>;
	Wed, 28 Nov 2001 15:23:44 -0500
Message-Id: <200111282023.fASKNUL15906@mailg.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Andrew Morton <akpm@zip.com.au>, Andre Hedrick <andre@linuxdiskcert.org>
Subject: Re: Unresponiveness of 2.4.16
Date: Wed, 28 Nov 2001 21:21:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011128013129Z281843-17408+21534@vger.kernel.org> <20011127183429.B862@mikef-linux.matchmail.com> <3C045072.36455C6F@zip.com.au>
In-Reply-To: <3C045072.36455C6F@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 November 2001 03:48, Andrew Morton wrote:
> Mike Fedyk wrote:
> > >       echo file_readahead:N > /proc/ide/ide0/hda/settings
> > >
> > > where N is in kilobytes in 2.4.16 kernels.
> >
> > Any idea which drivers it will/won't work on?  ie, "almost all ide" or
> > "almost none of the ide driers"?
>
> It appears that all IDE is controlled with /proc/ide/ide0/hda/settings
>
> > >In earlier kernels
> > > it's kilopages (!).
> >
> > Isn't this part of the max-readahead patch?
>
> No, that fix went in separately.  Roger Larsson created it, then
> I hit the same problem and forwarded Roger's patch to the relevant
> parties.
>

The reason I did not send it directly, but sent it to Andre for proper 
fix, is that the error is all over the place, this is from ide-cd.c

static void ide_cdrom_add_settings(ide_drive_t *drive)
{
	int major = HWIF(drive)->major;
	int minor = drive->select.b.unit << PARTN_BITS;

	ide_add_setting(drive,	"breada_readahead",	SETTING_RW, BLKRAGET, BLKRASET, 
TYPE_INT, 0, 255, 1, 2, &read_ahead[major], NULL);
	ide_add_setting(drive,	"file_readahead",	SETTING_RW, BLKFRAGET, BLKFRASET, 
TYPE_INTA, 0, INT_MAX, 1, 1024, &max_readahead[major][minor],	NULL);
	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW, BLKSECTGET, 
BLKSECTSET, TYPE_INTA, 1, 255, 1, 2, &max_sectors[major][minor], NULL);
	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 
1,	1, &drive->dsc_overlap, NULL);
}

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
