Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVJUHra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVJUHra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVJUHra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:47:30 -0400
Received: from digger1.defence.gov.au ([203.5.217.4]:18138 "EHLO
	digger1.defence.gov.au") by vger.kernel.org with ESMTP
	id S964899AbVJUHr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:47:29 -0400
Subject: Advantech Watchdog timer query.
From: Ryan Clayburn <ryan.clayburn@dsto.defence.gov.au>
Reply-To: ryan.clayburn@dsto.defence.gov.au
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: dsto
Message-Id: <1129880542.2194.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Oct 2005 17:12:23 +0930
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I work for a government agency so please forgive me for not having the
latest version of the kernel. My question concerns an Advantech card PCI
6870 Single Board Computer and its watchdog timer. I am running Redhat 9
linux 2.4.20-8 and it comes with module that supports the hardware
advantechwdt.o. I have been able install and communicate with the card.
Get and set the timeout or margin and get the support information of the
card. Everything seems to work except when i deliberately delay the ping
to the card to let it reboot the system as a watchdog should it does not
reboot. Is there something i am missing. Do i need a update to the
driver? I am attaching the code. It is fairly simple and a lot of it is
just reading and writing information read from the driver about the
card. I would appreciate any help.

Cheers

Ryan Clayburn

Can i please be CC'ed the answers/comments posted to the list in
response to my posting

************************************************************************
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/watchdog.h>
#include <time.h>
#include <sys/time.h>

int main(int argc, const char *argv[]) 
{
	int fd;
	struct watchdog_info *wdog_info;
	time_t timenow;
	char supportOptions[500];
	char dtime[50];
	int i, err;
	int timein, timeout;
	    
	fd = open("/dev/watchdog",O_WRONLY);
	
	if (fd==-1) 
	{
		perror("watchdog");
		return 1;
	}
	//printf("argc = %d\n", argc);
	err = ioctl(fd, WDIOC_GETSUPPORT, wdog_info);
	if (err < 0)
		printf("error is %d\n", err);
	if (wdog_info->options & WDIOF_KEEPALIVEPING)
		strcpy(supportOptions, "WDIOF_KEEPALIVEPING");
	if (wdog_info->options & WDIOF_MAGICCLOSE)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_MAGICCLOSE");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_MAGICCLOSE");
		}
	}
	if (wdog_info->options & WDIOF_SETTIMEOUT)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_SETTIMEOUT");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_SETTIMEOUT");
		}
	}
	if (wdog_info->options & WDIOF_POWEROVER)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_POWEROVER");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_POWEROVER");
		}
	}
	if (wdog_info->options & WDIOF_CARDRESET)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_CARDRESET");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_CARDRESET");
		}
	}
	if (wdog_info->options & WDIOF_POWERUNDER)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_POWERUNDER");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_POWERUNDER");
		}
	}
	if (wdog_info->options & WDIOF_EXTERN2)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_EXTERN2");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_EXTERN2");
		}
	}
	if (wdog_info->options & WDIOF_EXTERN1)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_EXTERN1");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_EXTERN1");
		}
	}
	if (wdog_info->options & WDIOF_FANFAULT)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_FANFAULT");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_FANFAULT");
		}
	}
	if (wdog_info->options & WDIOF_OVERHEAT)
	{
		if (strlen(supportOptions) == 0)
		{
			strcpy(supportOptions, "WDIOF_OVERHEAT");
		}
		else
		{
			strcat(supportOptions, " | WDIOF_OVERHEAT");
		}
	}
	
	printf("\nWATCHDOG TIMER DAEMON\n");
	printf("---------------------\n\n");
	printf("Wdioc Get Support Information\n");
	printf("-------------------------------------\n");
	printf("Options: %s\nFirmware Version: %d\n", supportOptions,
wdog_info->firmware_version);
	printf("Identity: ", wdog_info->identity);
	for (i = 0; i < 32; i++)
	{
		printf("%c", wdog_info->identity[i]);
	}
	printf("\n-------------------------------------\n\n");
	ioctl(fd, WDIOC_GETTIMEOUT, &timein);
	printf("The current timeout is %d seconds\n", timein);
	timeout = 30;
	ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
	printf("The timeout was set to %d seconds\n", timeout);
	time(&timenow);
	strcpy(dtime, ctime(&timenow));
	printf("%s", dtime);
	while(1)
	{
		//write(fd, "\0", 1);
		ioctl(fd, WDIOC_KEEPALIVE, 0);
		if (err < 0)
			printf("error is %d\n", err);
		sleep(timeout*2+10);
		time(&timenow);
		strcpy(dtime, ctime(&timenow));
		printf("%s", dtime);
	}
	close(fd);
	printf("bye bye...\n");
	return 0;
}


