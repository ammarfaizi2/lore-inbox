Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276000AbRI1KFh>; Fri, 28 Sep 2001 06:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275997AbRI1KF1>; Fri, 28 Sep 2001 06:05:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:26386 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275996AbRI1KFT>;
	Fri, 28 Sep 2001 06:05:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: jc <jcb@jcb.yi.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken in 2.4.10 
In-Reply-To: Your message of "Fri, 28 Sep 2001 11:09:23 +0200."
             <20010928110923.A12889@athena> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Sep 2001 20:05:35 +1000
Message-ID: <18757.1001671535@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001 11:09:23 +0200, 
jc <jcb@jcb.yi.org> wrote:
>how could i get the list of files that changed between 2.4.9 and 2.4.10
>concerning apm ?

diff -urN -I '$[ABD-Z].*\$' 2.4.9 2.4.10 > /var/tmp/patch-2.4.9-2.4.10
rm -rf /var/tmp/patches
split_patch /var/tmp/patch-2.4.9-2.4.10

Look through /var/tmp/patches for files and directories related to apm.
split_patch is

#!/usr/bin/perl -w
$out = "";
while (<>) {
	next if (/^Only/);
	next if (/^Binary/);
	if (/^diff/ || /^Index/) {
		if ($out) {
			close OUT;
		}
		(@out) = split(' ', $_);
		shift(@out) if (/^diff/);
		$out = pop(@out);
		$out =~ s:/*usr/:/:;
		$out =~ s:/*src/:/:;
		$out =~ s:^/*linux[^/]*::;
		$out =~ s:\(w\)::;
		next if ($out eq "");
		$out = "/var/tmp/patches/$out";
		$dir = $out;
		$dir =~ s:/[^/]*$::;
		print STDERR "$out\n";
		system("mkdir -p $dir");
		open(OUT, ">$out") || die("cannot open $out");
	}
	if ($out) {
		print OUT $_;
	}
}

