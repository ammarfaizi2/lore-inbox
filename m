Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUHRFGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUHRFGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 01:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUHRFGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 01:06:10 -0400
Received: from fmr99.intel.com ([192.55.52.32]:38045 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S268588AbUHRFEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 01:04:50 -0400
Subject: Re: [PATCH][ACPI] Panasonic Hotkey Driver
From: Len Brown <len.brown@intel.com>
To: Hiroshi Miura <miura@da-cha.org>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       letsnote-tech@ml.good-day.co.jp
In-Reply-To: <87d62cxnud.wl%miura@da-cha.org>
References: <87d62cxnud.wl%miura@da-cha.org>
Content-Type: multipart/mixed; boundary="=-hT69UIESje4fT7ez0s+t"
Organization: 
Message-Id: <1092805474.25902.126.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Aug 2004 01:04:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hT69UIESje4fT7ez0s+t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ah yes, another battle in the war on hot-keys;-)

On Sat, 2004-07-31 at 10:17, Hiroshi Miura wrote:
> Hi,
> 
> This is a  hotkey driver for Panasonic Lets note series. 
> I tested this driver on 2.6.7 kernel and Panasonic CF-R3 laptop. 
> Using this driver, users can handle Fn+Fx key (except for Fn+F3) with
> acpid.
> 
> The event is for example 'HKEY HKEY 00000080 0000001' for Fn+F1.

Would be good if you had a comment that listed what hot keys are
available etc.

> 
> sample scripts as follows
> 
> # /etc/acpi/events/hotkey
> event=HKEY.*
> action=/etc/acpi/hotkey.sh "%e"
> 
> hotkey.sh is
> 
> #!/bin/sh
> set $*
> # Take care about the way events are reported
> key="$4";
> 
> case "$key" in
>      0000000a)
>            logger "acpid: received a suspend request"
>            echo 1 > /proc/swsusp/activate
>            hwclock --hctosys
>            break
>            ;;
>      *)
>            logger "acpid: action $key is not defined"
>            ;;
> esac
> 
> 
> 
> 
> patch is follows
> 
> # This is a BitKeeper generated diff -Nru style patch.

Since you're using bitkeeper, one option is to preserve your check-in
comments by sending me the patch via bjorn's bkexport script (attached).
Though I reserve the right to edit all comments;-)

> # ChangeSet
> #   2004/07/26 11:50:39+09:00 miura@da-cha.org 
> #   Panasonic Laptop Extra driver.
> #   This adds support of hotkey (Fn+Fx) on Panasonic Lets note Laptop
> series.
> #   Loding this driver, user can get event through acpid like "HKEY
> HKEY 0000080 000001"
> #   
> #   Signed-off-by: Hiroshi Miura <miura@da-cha.org>
> # 
> # drivers/acpi/pcc_acpi.c
> #   2004/07/26 11:50:23+09:00 miura@da-cha.org +518 -0
> # 
> # drivers/acpi/pcc_acpi.c
> #   2004/07/26 11:50:23+09:00 miura@da-cha.org +0 -0
> #   BitKeeper file
> /home/miura/kernel/linux-2.6.7-hm/drivers/acpi/pcc_acpi.c
> # 
> # drivers/acpi/Makefile
> #   2004/07/26 11:50:23+09:00 miura@da-cha.org +1 -0
> #   add Panasonic Laptop Extra driver entry
> # 
> # drivers/acpi/Kconfig
> #   2004/07/26 11:50:23+09:00 miura@da-cha.org +20 -0
> #   add Panasonic Laptop Extra driver entry
> # 
> diff -Nru a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> --- a/drivers/acpi/Kconfig      2004-07-27 12:44:53 +09:00
> +++ b/drivers/acpi/Kconfig      2004-07-27 12:44:53 +09:00
> @@ -204,6 +204,26 @@
>           If you have a legacy free Toshiba laptop (such as the
> Libretto L1
>           series), say Y.
>  
> +config ACPI_PCC
> +       tristate "Panasonic Laptop Extras"

how about  calling it a hot key driver instead of an "extras driver",
unless there is something other than hot keys coming.

> +       depends on X86
> +       depends on ACPI_INTERPRETER

CONFIG_ACPI_INTERPRETER options is going away, okay to leave it out.

> +       default m
> +       ---help---
> +         This driver adds support for access to certain system
> settings
> +         on panasonic Let's Note laptops. 
> +
> +         On these machines, all hotkey is handled through the ACPI.
> +         This driver is required for access to controls not covered
> +         by the general ACPI drivers, such as LCD brightness, video
> output,
> +         etc.
> +
> +         More information about this driver will be available at
> +         <http://www.da-cha.org/letsnote/>
> +
> +         If you have a panasonic lets note laptop (such as the CF-T2,
> Y2,
> +         R2, W2, R3), say Y.
> +
>  config ACPI_DEBUG
>         bool "Debug Statements"
>         depends on ACPI_INTERPRETER
> diff -Nru a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> --- a/drivers/acpi/Makefile     2004-07-27 12:44:53 +09:00
> +++ b/drivers/acpi/Makefile     2004-07-27 12:44:53 +09:00
> @@ -47,4 +47,5 @@
>  obj-$(CONFIG_ACPI_NUMA)                += numa.o
>  obj-$(CONFIG_ACPI_ASUS)                += asus_acpi.o
>  obj-$(CONFIG_ACPI_TOSHIBA)     += toshiba_acpi.o
> +obj-$(CONFIG_ACPI_PCC)         += pcc_acpi.o
>  obj-$(CONFIG_ACPI_BUS)         += scan.o 
> diff -Nru a/drivers/acpi/pcc_acpi.c b/drivers/acpi/pcc_acpi.c
> --- /dev/null   Wed Dec 31 16:00:00 196900
> +++ b/drivers/acpi/pcc_acpi.c   2004-07-27 12:44:53 +09:00
> @@ -0,0 +1,518 @@
> +/*
> + *  Panasonic HotKey control Extra driver
> + *  (C) 2004 Hiroshi Miura <miura@da-cha.org>
> + *  (C) 2004 NTT DATA Intellilink Co. http://www.intellilink.co.jp/
> + *  All Rights Reserved
> + *
> + *  This program is free software; you can redistribute it and/or
> modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  publicshed by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + * *  You should have received a copy of the GNU General Public
> License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
> 02111-1307  USA
> + *
> + *  The devolpment page for this driver will be located at
> + *  http://www.da-cha.org/
> + *
> +
> *---------------------------------------------------------------------------
> + *
> + * ChangeLog:
> + *     Jul.25, 2004    Hiroshi Miura <miura@da-cha.org>
> + *             - v0.4  first post version
> + *             -       add debug function to retrive SIFR
> + *
> + *     Jul.24, 2004    Hiroshi Miura <miura@da-cha.org>
> + *             - v0.3  get proper status of hotkey
> + *
> + *      Jul.22, 2004   Hiroshi Miura <miura@da-cha.org>
> + *             - v0.2  add HotKey handler
> + *
> + *      Jul.17, 2004   Hiroshi Miura <miura@da-cha.org>
> + *             - v0.1  based on acpi video driver
> + *

would be polite to credit the exact files that you leveraged.

> + *  TODO
> + *     everything all
> + *
> + */
> +
> +#define ACPI_PCC_VERSION       "0.4"
> +#define PROC_INTERFACE_VERSION 2
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/proc_fs.h>
> +#include <asm/uaccess.h>
> +
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +
> +MODULE_AUTHOR("Hiroshi Miura");
> +MODULE_DESCRIPTION("ACPI HotKey driver for lets note");
> +MODULE_LICENSE("GPL");
> +
> +#define LOGPREFIX "acpi_pcc: "
> +
> +/****************************************************
> + * Define ACPI PATHs 
> + ****************************************************/
> +/* crt/lcd hot key definitions */
> +#define DEVICE_NAME_VGA                "\\_SB_.PCI0.GRFX"
> +#define DEVICE_NAME_CRT                "CRT1"
> +#define DEVICE_NAME_LCD                "LCD1"

These three are unused and should be deleted.
(they should be part of the video driver)

> +#define METHOD_CHGD            "\\_SB_.CHGD"
> +
> +/* Lets note hotkeys definitions */
> +#define DEVICE_NAME_HKEY       "\\_SB_.HKEY"
> +#define METHOD_HKEY_QUERY      "HINF"
> +
> +/* ACPI BIOS inside use only? */
> +#define METHOD_HKEY_RESET      "HRES"
> +#define METHOD_HKEY_SAVE       "HSAV"
> +#define METHOD_HKEY_HIND       "HIND"
> +
> +/* event read/write functions */
> +#define METHOD_HKEY_SQTY       "SQTY"
> +#define METHOD_HKEY_SINF       "SINF"
> +#define METHOD_HKEY_SSET       "SSET"
> +
> +
> +/* device(HKEY) definitions */
> +#define HKEY_HID               "MAT0019"

I'm extremely pleased to see this keys off a HID.

> +#define HKEY_NOTIFY             0x80
> +
> +/*******************************************************************
> + *
> + * definitions for /proc/ interface
> + *
> + *******************************************************************/
> +#define PROC_PCC               "pcc"
> +
> +#define ACPI_HOTKEY_DRIVER_NAME "PCC HotKey Driver"
> +#define ACPI_HOTKEY_DEVICE_NAME "HotKey"
> +#define ACPI_HOTKEY_CLASS "HKEY"
> +
> +static int acpi_hotkey_add (struct acpi_device *device);
> +static int acpi_hotkey_remove (struct acpi_device *device, int type);
> +
> +static struct acpi_driver acpi_hotkey_driver = {
> +       .name =         ACPI_HOTKEY_DRIVER_NAME,
> +       .class =        ACPI_HOTKEY_CLASS,
> +       .ids =          HKEY_HID,
> +       .ops =          {
> +                               .add =          acpi_hotkey_add,
> +                               .remove =       acpi_hotkey_remove,
> +                       },
> +};
> +
> +struct acpi_hotkey {
> +       acpi_handle             handle;
> +       struct acpi_device      *device;
> +       unsigned long           status;
> +};
> +
> +
> +/*
> + * utility functions
> + */
> +static __inline__ void
> +_set_bit(u32* word, u32 mask, int value)
> +{
> +       *word = (*word & ~mask) | (mask * value);
> +}
> +
> +/* acpi interface wrappers
> + */
> +static int
> +is_valid_acpi_path(const char* methodName)
> +{
> +       acpi_handle handle;
> +       acpi_status status;
> +
> +       status = acpi_get_handle(0, (char*)methodName, &handle);
> +       return !ACPI_FAILURE(status);
> +}
> +
> +#if 0
> +static int
> +write_acpi_int(const char* methodName, int val)
> +{
> +       struct acpi_object_list params;
> +       union acpi_object in_objs[1];
> +       acpi_status status;
> +
> +       params.count = sizeof(in_objs)/sizeof(in_objs[0]);
> +       params.pointer = in_objs;
> +       in_objs[0].type = ACPI_TYPE_INTEGER;
> +       in_objs[0].integer.value = val;
> +
> +       status = acpi_evaluate_object(0, (char*)methodName, &params,
> 0);
> +       return (status == AE_OK);
> +}
> +#endif

hmm, this dead code above looks familiar:-)

we'll want to clean out the #if 0's, or at least
put them under a descriptive #ifdef, yes?

> +
> +static int
> +read_acpi_int(acpi_handle handle, const char* methodName, int* pVal)
> +{
> +       struct acpi_buffer results;
> +       union acpi_object out_objs[1];
> +       acpi_status status;
> +
> +       results.length = sizeof(out_objs);
> +       results.pointer = out_objs;
> +
> +       status = acpi_evaluate_object(handle, (char*)methodName, 0,
> &results);
> +       if (ACPI_FAILURE(status)) {
> +               printk(KERN_INFO "acpi evaluate error on %s\n",
> methodName);
> +               return (-EFAULT);
> +       }
> +
> +       if (out_objs[0].type == ACPI_TYPE_INTEGER) {
> +               *pVal = out_objs[0].integer.value;
> +       } else {
> +               printk(KERN_INFO "return value is not int\n");
> +               status = AE_ERROR;
> +       }
> +
> +       return (status == AE_OK);
> +}
> +
> +static struct proc_dir_entry*  acpi_pcc_dir;
> +
> +typedef struct _ProcItem
> +{
> +       const char* name;
> +       char* (*read_func)(char*);
> +       unsigned long (*write_func)(const char*, unsigned long);
> +} ProcItem;
> +
> +
> +/* register utils for proc handler */
> +static int
> +dispatch_read(char* page, char** start, off_t off, int count, int*
> eof,
> +       ProcItem* item)
> +{
> +       char* p = page;
> +       int len;
> +
> +       if (off == 0)
> +               p = item->read_func(p);
> +
> +       /* ISSUE: I don't understand this code */
> +       len = (p - page);
> +       if (len <= off+count) *eof = 1;
> +       *start = page + off;
> +       len -= off;
> +       if (len>count) len = count;
> +       if (len<0) len = 0;
> +       return len;
> +}
> +
> +static int
> +dispatch_write(struct file* file, __user const char* buffer,
> +       unsigned long count, ProcItem* item)
> +{
> +       int result;
> +       char* tmp_buffer;
> +
> +       /* Arg buffer points to userspace memory, which can't be
> accessed
> +        * directly.  Since we're making a copy, zero-terminate the
> +        * destination so that sscanf can be used on it safely.
> +        */
> +       tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
> +       if (copy_from_user(tmp_buffer, buffer, count)) {
> +               result = -EFAULT;
> +       }
> +       else {
> +               tmp_buffer[count] = 0;
> +               result = item->write_func(tmp_buffer, count);
> +       }
> +       kfree(tmp_buffer);
> +       return result;
> +}
> +
> +/*
> + * proc file handlers
> + */

Of course we're trying to get away from /proc at this point and head for
sysfs...

> +#ifdef DEBUG_PCC_VGA
> +static unsigned long
> +write_chgd(const char* buffer, unsigned long count)
> +{
> +       int value;
> +       acpi_status status;
> +
> +       if (sscanf(buffer, "%i", &value) == 1 && value >= 0 && value <
> 2) {
> +               if (value == 0) 
> +                       /* do nothing */
> +                       status = AE_OK;
> +               else {
> +                       status = acpi_evaluate_object(0, METHOD_CHGD,
> 0 , 0);
> +               }
> +               if (ACPI_FAILURE(status)) {
> +                       printk(KERN_INFO LOGPREFIX "fail evaluate
> CHGD()\n");
> +                       return -EFAULT;
> +               }
> +       }
> +       return count;
> +
> +}
> +
> +static char*
> +read_nothing(char* p)
> +{
> +       /* nothing to do*/
> +       return p;
> +}
> +#endif
> +
> +static char*
> +read_hkey_status(char* p)
> +{
> +       acpi_status status;
> +       struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +       union acpi_object *hkey = NULL;
> +       int i, num_sifr;
> +
> +       if (!read_acpi_int(NULL, DEVICE_NAME_HKEY "."
> METHOD_HKEY_SQTY, &num_sifr)){
> +               printk(KERN_INFO LOGPREFIX "evaluation error
> HKEY.SQTY\n");
> +               return p;
> +       }
> +
> +       status = acpi_evaluate_object(NULL, DEVICE_NAME_HKEY "."
> METHOD_HKEY_SINF, 0 , &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               printk(KERN_INFO LOGPREFIX "evaluation error
> HEKY.SINF\n");
> +               return p;
> +       }
> +       hkey = (union acpi_object *) buffer.pointer;
> +       if (!hkey || (hkey->type != ACPI_TYPE_PACKAGE)) {
> +               printk(KERN_INFO LOGPREFIX "Invalid HKEY.SINF\n");
> +               goto end;
> +       }
> +       
> +       if (num_sifr != hkey->package.count) {
> +               printk(KERN_INFO LOGPREFIX "SQTY is not equal to SINF
> length?\n");
> +               goto end;
> +       }
> +
> +       for (i = 0; i < hkey->package.count; i++) {
> +               union acpi_object *element =
> &(hkey->package.elements[i]);
> +               if (likely(element->type == ACPI_TYPE_INTEGER)) {
> +                       p += sprintf(p, "0x%02x,\n", (unsigned
> int)element->integer.value);
> +               } else
> +                       printk(KERN_INFO LOGPREFIX "Invalid HKEY.SINF
> value\n");
> +       }
> +end:
> +       acpi_os_free(buffer.pointer);
> +       return p;
> +}
> +
> +
> +static char*
> +read_version(char* p)
> +{
> +       p += sprintf(p, "%s version %s\n", ACPI_HOTKEY_DRIVER_NAME,
> ACPI_PCC_VERSION);
> +       p += sprintf(p, "proc_interface version %d\n",
> PROC_INTERFACE_VERSION);
> +       return p;
> +}
> +
> +
> +/* hotkey driver */
> +static int
> +acpi_hotkey_get_key(struct acpi_hotkey *hotkey)
> +{
> +       int result;
> +       int status;
> +
> +       status = read_acpi_int(hotkey->handle, METHOD_HKEY_QUERY,
> &result);
> +       if (!status) {
> +               printk(KERN_INFO LOGPREFIX "error getting hotkey
> status\n");
> +       } else
> +               hotkey->status = result;
> +
> +       return (status);
> +}
> +
> +void
> +acpi_hotkey_notify(acpi_handle handle, u32 event, void *data)
> +{
> +       struct acpi_hotkey      *hotkey = (struct acpi_hotkey *) data;
> +
> +       if (!hotkey || !hotkey->device)
> +               return;
> +
> +       switch(event) {
> +       case HKEY_NOTIFY:
> +               if (acpi_hotkey_get_key(hotkey))
> +                       acpi_bus_generate_event(hotkey->device, event,
> hotkey->status);
> +               break;
> +       default:
> +               /* nothing to do */
> +               break;
> +       }
> +
> +       return;
> +}
> +
> +static int
> +acpi_hotkey_add (struct acpi_device *device)
> +{
> +       int                     result = 0;
> +       acpi_status             status = AE_OK;
> +       struct acpi_hotkey      *hotkey = NULL;
> +
> +       if (!device)
> +               return (-EINVAL);
> +
> +       hotkey = kmalloc(sizeof(struct acpi_hotkey), GFP_KERNEL);
> +       if (!hotkey)
> +               return (-ENOMEM);
> +
> +       memset(hotkey, 0, sizeof(struct acpi_hotkey));
> +
> +       hotkey->device = device;
> +       hotkey->handle = device->handle;
> +       acpi_driver_data(device) = hotkey;
> +       strcpy(acpi_device_name(device), ACPI_HOTKEY_DEVICE_NAME);
> +       strcpy(acpi_device_class(device), ACPI_HOTKEY_CLASS);
> +
> +       status = acpi_install_notify_handler (
> +                       hotkey->handle,
> +                       ACPI_DEVICE_NOTIFY,
> +                       acpi_hotkey_notify,
> +                       hotkey);
> +       if (ACPI_FAILURE(status)) 
> +               result = -ENODEV;
> +
> +       if (result)
> +               kfree(hotkey);
> +
> +       return (result);
> +}
> +
> +static int
> +acpi_hotkey_remove(struct acpi_device *device, int type)
> +{
> +       acpi_status             status = 0;
> +       struct acpi_hotkey      *hotkey = NULL;
> +
> +       if (!device || !acpi_driver_data(device))
> +               return(-EINVAL);
> +
> +       hotkey = acpi_driver_data(device);
> +       status = acpi_remove_notify_handler(hotkey->handle,
> +                   ACPI_DEVICE_NOTIFY, acpi_hotkey_notify);
> +       if (ACPI_FAILURE(status))
> +               printk(KERN_INFO LOGPREFIX "Error removing notify
> handler\n");
> +
> +       kfree(hotkey);
> +
> +       return(0);
> +}
> +
> +/*
> + * proc and module init
> +*/
> +
> +ProcItem pcc_proc_items[] =
> +{
> +#ifdef DEBUG_PCC_VGA
> +       { "chgd"   , read_nothing , write_chgd},
> +#endif
> +       { "hkey_status", read_hkey_status, NULL},
> +       { "version", read_version , NULL},
> +       { NULL     , NULL         , NULL},
> +};
> +
> +static acpi_status __init
> +add_device(ProcItem *proc_items, struct proc_dir_entry* proc_entry)
> +{
> +       struct proc_dir_entry* proc;
> +       ProcItem* item;
> +
> +       for (item = proc_items; item->name; ++item)
> +       {
> +               proc = create_proc_read_entry(item->name,
> +                       S_IFREG | S_IRUGO | S_IWUSR,
> +                       proc_entry, (read_proc_t*)dispatch_read,
> item);
> +               if (proc)
> +                       proc->owner = THIS_MODULE;
> +               if (proc && item->write_func)
> +                       proc->write_proc =
> (write_proc_t*)dispatch_write;
> +       }
> +
> +       return(AE_OK);
> +}
> +
> +
> +static int __init
> +pcc_proc_init(void)
> +{
> +       acpi_status status = AE_OK;
> +
> +       if (unlikely(!(acpi_pcc_dir = proc_mkdir(PROC_PCC,
> acpi_root_dir))))
> +               return -ENODEV;
> +
> +       acpi_pcc_dir->owner = THIS_MODULE;
> +       status = add_device(pcc_proc_items, acpi_pcc_dir);
> +       if (ACPI_FAILURE(status)){
> +               remove_proc_entry(PROC_PCC, acpi_root_dir);
> +               return -ENODEV;
> +       }
> +
> +       return (status == AE_OK);
> +}
> +
> +static acpi_status __exit
> +remove_device(ProcItem *proc_items, struct proc_dir_entry*
> proc_entry)
> +{
> +       ProcItem* item;
> +
> +       for (item = proc_items; item->name; ++item)
> +               remove_proc_entry(item->name, proc_entry);
> +       return(AE_OK);
> +}
> +
> +
> +
> +/* init funcs. */
> +static int __init
> +acpi_pcc_init(void)
> +{
> +       acpi_status result = AE_OK;
> + 
> +       if (acpi_disabled)
> +               return -ENODEV;
> +
> +       /* simple device detection: look forI method */
> +       if (!(is_valid_acpi_path(METHOD_CHGD)))
> +               return -ENODEV;

Why is this necessary if you key off the HID with
acpi_bus_register_driver below?

> +
> +       result = acpi_bus_register_driver(&acpi_hotkey_driver);
> +       if (ACPI_FAILURE(result))
> +               printk(KERN_INFO LOGPREFIX "Error registering hotkey
> driver\n");
> +
> +       printk(KERN_INFO LOGPREFIX "ACPI PCC HotKey driver version
> %s\n", ACPI_PCC_VERSION);
> +
> +       return (pcc_proc_init());
> +
> +}
> +
> +static void __exit
> +acpi_pcc_exit(void)
> +{
> +       if (acpi_pcc_dir) {
> +               remove_device(pcc_proc_items, acpi_pcc_dir);
> +               remove_proc_entry(PROC_PCC, acpi_root_dir);
> +       }
> +       acpi_bus_unregister_driver(&acpi_hotkey_driver); 
> +       return;
> +}
> +
> +module_init(acpi_pcc_init);
> +module_exit(acpi_pcc_exit);
>  
> 
> -- 
> Hiroshi Miura  --- http://www.da-cha.org/  --- miura@da-cha.org
> NTTDATA Corp. OpenSource Software Center. --- miurahr@nttdata.co.jp 
> NTTDATA Intellilink Corp. OpenSource Engineering Dev. --
> miurahr@intellilink.co.jp
> Key fingerprint = 9117 9407 5684 FBF1 4063  15B4 401D D077 04AB 8617
> 

--=-hT69UIESje4fT7ez0s+t
Content-Disposition: attachment; filename=bkexport
Content-Type: text/plain; name=bkexport; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

# Export a bitkeeper patch, adding author and per-file comments

if [ $# -gt 1 ]; then
	CSET=`bk r2c $*`
	CSET="-r$CSET"
else
	CSET=$1
fi

echo -n "#### AUTHOR "
bk cset $CSET |\
    awk -F\| "{printf \"bk prs -r%s -h -d '\$if(:DPN:=ChangeSet){:USER:@:HOST:\\n}' %s\n\", \$2, \$1}" |\
    sh
echo "#### COMMENT START"
bk cset $CSET |\
    awk -F\| "{printf \"bk prs -r%s -h -d '### Comments for :DPN:\\n\$each(:C:){(:C:)\\n}' %s\n\", \$2, \$1}" |\
    sh
echo "#### COMMENT END"
echo

bk export -tpatch -du $CSET

--=-hT69UIESje4fT7ez0s+t
Content-Disposition: attachment; filename=bkimport
Content-Type: text/plain; name=bkimport; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

# Import a bitkeeper patch, preserving author and per-file comments

_import() {
    PATCH=$1

    FROM=`grep '^#### AUTHOR' $PATCH`
    export BK_USER=`echo $FROM | sed -e 's/^#### AUTHOR //' -e 's/@.*//'`
    export BK_HOST=`echo $FROM | sed -e 's/.*@//'`

    echo Importing $PATCH from $BK_USER@$BK_HOST

    #bk import -tpatch -qR $PATCH .
    bk import -tpatch -vR $PATCH .
    if [ $? -ne 0 ]; then
	echo $PATCH: import failed
	exit 0
    fi
    cat $PATCH |\
	awk "/#### COMMENT START/ {p=1; next}; /#### COMMENT END/ {exit}; p==1" |\
	bk comments -
}

for P in $@; do
    _import $P
done

--=-hT69UIESje4fT7ez0s+t--

