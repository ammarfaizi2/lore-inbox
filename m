Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946382AbWJTNa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946382AbWJTNa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946400AbWJTNa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:30:57 -0400
Received: from mx6.mail.ru ([194.67.23.26]:62256 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1946382AbWJTNa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:30:57 -0400
Date: Fri, 20 Oct 2006 17:32:05 +0400
From: Anton Vorontsov <cbou@mail.ru>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061020133204.GA25204@localhost>
Reply-To: cbou@mail.ru
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610201339.49190.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <200610201339.49190.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi,

On Fri, Oct 20, 2006 at 01:39:49PM +0200, Mariusz Kozlowski wrote:
> Hello, 
> 
> 	I installed 2.6.19-rc2-mm2 without kernel debugging options enabled first. 
> The output below is what I saw when the kernel started. Then I enabled 
> debugging and system hangs with oops with no trace in the logs. It is not 
> easily repeatable though. It happens from time to time.
> 

Is that patch helps?

> Regards,
> 
> 	Mariusz Kozlowski

-- Anton (irc: bd2)

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="pcmcia-fix.patch"

diff --git a/drivers/pcmcia/pcmcia_ioctl.c b/drivers/pcmcia/pcmcia_ioctl.c
index 9ad18e6..72d92b4 100644
--- a/drivers/pcmcia/pcmcia_ioctl.c
+++ b/drivers/pcmcia/pcmcia_ioctl.c
@@ -601,6 +601,10 @@ static int ds_ioctl(struct inode * inode
 	    ret = CS_BAD_ARGS;
 	else {
 	    struct pcmcia_device *p_dev = get_pcmcia_device(s, buf->config.Function);
+	    if (!p_dev) {
+		    err = -ENODEV;
+		    break;
+	    }
 	    ret = pccard_get_configuration_info(s, p_dev, &buf->config);
 	    pcmcia_put_dev(p_dev);
 	}
@@ -632,6 +636,10 @@ static int ds_ioctl(struct inode * inode
 		    ret = CS_BAD_ARGS;
 	    else {
 		    struct pcmcia_device *p_dev = get_pcmcia_device(s, buf->status.Function);
+		    if (!p_dev) {
+			    err = -ENODEV;
+			    break;
+		    }
 		    ret = pccard_get_status(s, p_dev, &buf->status);
 		    pcmcia_put_dev(p_dev);
 	    }

--ibTvN161/egqYuK8--
