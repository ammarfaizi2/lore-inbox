Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289793AbSBJVpH>; Sun, 10 Feb 2002 16:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289794AbSBJVo5>; Sun, 10 Feb 2002 16:44:57 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:48862 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S289793AbSBJVoq>; Sun, 10 Feb 2002 16:44:46 -0500
Date: Sun, 10 Feb 2002 16:44:35 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: TUN/TAP driver doesn't work. 
Message-ID: <Pine.NEB.4.33.0202101644050.21436-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to use TUN/TAP driver. My OS is RH71, kernel is 2.4.17, with
tuntap compiled as a module. Module is inserted properly when I try to
open '/dev/net/tun', and I get kernel message saying "TUN/TAP universal
driver, (c)...etc.". But ioctls don't work and always return '-1'.
To test it I was using code from tuntap's documentation (included below this
message and btw I don't understand dev's name str-copying in this code)
and pengaol, newest version, which I know works with tuntap. None of these
2 programs work for me.

Any help would be really greatly appreciated.

-marek

-- test code --
#include        <sys/fcntl.h>
#include        <sys/ioctl.h>
#include        <net/if.h>
#include        <linux/if_tun.h>

int tun_alloc(char *dev)
{
    struct ifreq ifr;
    int fd, err;

    if( (fd = open("/dev/net/tun", O_RDWR)) < 0 ) {
       printf("open error\n");
   	 return 0;
    }

    memset(&ifr, 0, sizeof(ifr));

    /* Flags: IFF_TUN   - TUN device (no Ethernet headers)
     *        IFF_TAP   - TAP device
     *        IFF_NO_PI - Do not provide packet information
     *
     */
    ifr.ifr_flags = IFF_TUN;

    if( *dev )
        strncpy(ifr.ifr_name, dev, IFNAMSIZ);

    if( (err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0 ){
        printf("ioctl err %d: %s\n", err, strerror(err));
        close(fd);
        return err;
    }
    strcpy(dev, ifr.ifr_name);
    return fd;
}

int main(int argc, char **argv)
{
	char test[100] = "1234567890123456";
	tun_alloc(test);
	return 0;
}



