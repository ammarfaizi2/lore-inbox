Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292221AbSBBE3e>; Fri, 1 Feb 2002 23:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292222AbSBBE3V>; Fri, 1 Feb 2002 23:29:21 -0500
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:47378 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S292221AbSBBE3K>;
	Fri, 1 Feb 2002 23:29:10 -0500
Date: Fri, 1 Feb 2002 20:29:08 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Deepinder Singh <dsingh@somanetworks.com>
Cc: George Bonser <george@gator.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory leaks with GRE Tunnels
Message-ID: <20020201202908.C12028@ecam.san.rr.com>
In-Reply-To: <CHEKKPICCNOGICGMDODJKEHPGDAA.george@gator.com> <3C599DBC.2040802@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3C599DBC.2040802@somanetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think there is a kernel problem, there is an ioctl to delete
tunnels and it does work. if tun0 down does not delete the tunnel you
need to send down the ioctl as well. I don't know what user tools do
this for you, I have always done my own.

This is all the code ryou really need

{
	struct ifreq ifr;
	int fd;
        int i=0;

	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
                SYSLOG(LOG_DAEMON | LOG_ERR, "Cannot open socket to close tunnel(s)\n");
                return;
        }

        sprintf(ifr.ifr_name,"tun%d", i);
        if( (ioctl(fd, SIOCDELTUNNEL, &ifr) < 0) {
                        SYSLOG(LOG_DAEMON | LOG_ERR, "Can't DELTUNNEL %s (%m)\n", ifr.ifr_name);
                }

