Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRGFNfL>; Fri, 6 Jul 2001 09:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266689AbRGFNfB>; Fri, 6 Jul 2001 09:35:01 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:6787
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S266688AbRGFNet>; Fri, 6 Jul 2001 09:34:49 -0400
Message-ID: <3B45BE6C.5DBE4F35@nortelnetworks.com>
Date: Fri, 06 Jul 2001 09:34:36 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: are ioctl calls supposed to take this long?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am using the following snippet of code to find out some information about the
MII PHY interface of my ethernet device (which uses the tulip driver).  When I
did some timing measurements with gettimeofday() I found that the ioctl call
takes a bit over a millisecond to complete.  This seems to me to be an awfully
long time for what should be (as far as I can see) a very simple operation.

Is this the normal amount of time that this should take, and if so then why in
the world does it take so long?  If not, then does anyone have any idea why it's
taking so long?

Thanks,

Chris



// code follows //


int skfd;
struct ifreq ifr;
ifname = "eth1";
   
if ((skfd = socket(AF_INET, SOCK_DGRAM,0)) < 0)
{
   perror("socket");
   exit(-1);
}
   
strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
   
if (ioctl(skfd, SIOCDEVPRIVATE, &ifr) < 0)
{
   fprintf(stderr, "SIOCDEVPRIVATE, on %s failed: %s\n", ifname,
strerror(errno));
   close(skfd);
   exit(-1);
}









-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
